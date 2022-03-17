#include "TCPReceiver.h"

TCPReceiver::TCPReceiver():BaseNumber(0)
{
	for (int i = 0; i < WINDOW_SIZE; i++) {
		this->packetsReceived[i].acknum = -1;	//初始状态下，确认包的确认序号为-1
		this->packetsReceived[i].seqnum = -1;	//忽略该字段
	}
}

TCPReceiver::~TCPReceiver()
{
}

void TCPReceiver::receive(const Packet& packet)
{
	Packet packet_init;
	packet_init.acknum = -1;
	packet_init.seqnum = -1;
	for (int i = 0; i < Configuration::PAYLOAD_SIZE; i++) {
		packet_init.payload[i] = '.';
	}
	packet_init.checksum = pUtils->calculateCheckSum(packet_init);

	//检查校验和是否正确
	int checkSum = pUtils->calculateCheckSum(packet);

	if (checkSum == packet.checksum)
	{
		int acknum = packet.seqnum;

		if (acknum == this->BaseNumber) {
			//收到期望的序号
			this->packetsReceived[0] = packet;
			this->packetsReceived[0].acknum = packet.seqnum;
			this->packetsReceived[0].seqnum = -1;

			int number = 0;
			Message msg;
			while (this->packetsReceived[number].acknum != -1) {
				//取出Message，向上递交给应用层
				memcpy(msg.data, this->packetsReceived[number].payload, sizeof(this->packetsReceived[number].payload));
				pns->delivertoAppLayer(RECEIVER, msg);
				number = number + 1;
				if (number == WINDOW_SIZE)
					break;
			}
			//更新接收窗口
			for (int i = 0; i < WINDOW_SIZE; i++) {
				if (i < (WINDOW_SIZE - number))
					this->packetsReceived[i] = this->packetsReceived[i + number];
				else
					this->packetsReceived[i] = packet_init;
			}

			this->BaseNumber = (this->BaseNumber + number) % MAXID;

			packet_init.acknum = this->BaseNumber;
			packet_init.checksum = pUtils->calculateCheckSum(packet_init);
			pUtils->printPacket("接收方发送确认报文", packet_init);
			pns->sendToNetworkLayer(SENDER, packet_init);	//调用模拟网络环境的sendToNetworkLayer，通过网络层发送确认报文到对方

		}
		else {
			if (((this->BaseNumber + WINDOW_SIZE - 1) < MAXID) ? ((acknum > this->BaseNumber) && (acknum <= this->BaseNumber + WINDOW_SIZE - 1)) : ((acknum > this->BaseNumber) || (acknum <= ((this->BaseNumber + WINDOW_SIZE - 1) % MAXID)))) {
				//收到非期望但有用的序号
				int serial = 0;
				if (acknum < this->BaseNumber)
					serial = acknum + MAXID - this->BaseNumber;
				else
					serial = acknum - this->BaseNumber;

				this->packetsReceived[serial] = packet;
				this->packetsReceived[serial].acknum = packet.seqnum;
				this->packetsReceived[serial].seqnum = -1;
			}

			//构造冗余ACK
			packet_init.acknum = this->BaseNumber;
			packet_init.checksum = pUtils->calculateCheckSum(packet_init);
			pUtils->printPacket("接收方发送冗余ACK", packet_init);
			pns->sendToNetworkLayer(SENDER, packet_init);	//调用模拟网络环境的sendToNetworkLayer，通过网络层发送确认报文到对方
		}
	}
}
