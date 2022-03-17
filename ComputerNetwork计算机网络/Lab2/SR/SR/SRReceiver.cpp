#include "SRReceiver.h"

SRReceiver::SRReceiver():expectSequenceNumberRcvd(0)
{
	for (int i = 0; i < N; i++)
	{
		this->receiverAckPkt[i].acknum = -1;	//初始状态下，确认包的确认序号为-1
		this->receiverAckPkt[i].seqnum = -1;	//忽略该字段
	}
}

SRReceiver::~SRReceiver()
{
}

void SRReceiver::receive(const Packet& packet)
{
	// 检查校验和是否正确
	int checkSum = pUtils->calculateCheckSum(packet);

	if (checkSum == packet.checksum)
	{
		int seqNum = packet.seqnum;

		pUtils->printPacket("接收方收到报文待处理", packet);

		if (seqNum == this->expectSequenceNumberRcvd)
		{
			this->receiverAckPkt[0] = packet;
			this->receiverAckPkt[0].acknum = packet.seqnum;
			this->receiverAckPkt[0].seqnum = -1;
			pUtils->printPacket("接收方发送确认报文", this->receiverAckPkt[0]);
			pns->sendToNetworkLayer(SENDER, this->receiverAckPkt[0]);	//调用模拟网络环境的sendToNetworkLayer，通过网络层发送确认报文到对方

			int ackedNumBeforeFirstUnacked = 0;
			Message msg;
			for (int i = 0; i < N; i++)
			{
				if (this->receiverAckPkt[i].acknum >= 0)
				{
					this->expectSequenceNumberRcvd++;
					ackedNumBeforeFirstUnacked++;
					memcpy(msg.data, this->receiverAckPkt[i].payload, sizeof(this->receiverAckPkt[i].payload));
					pns->delivertoAppLayer(RECEIVER, msg);
				}
				else {
					break;
				}
			}

			this->expectSequenceNumberRcvd %= MAXID;

			cout << "下一个序号：" << this->expectSequenceNumberRcvd << endl;

			Packet packet_init;
			packet_init.acknum = -1;
			packet_init.seqnum = -1;
			for (int i = 0; i < Configuration::PAYLOAD_SIZE; i++) {
				packet_init.payload[i] = '.';
			}
			packet_init.checksum = pUtils->calculateCheckSum(packet_init);

			for (int i = 0; i < N; i++)
			{
				cout << this->receiverAckPkt[i].seqnum << "\t" << this->receiverAckPkt[i].payload << endl;
				if (i + ackedNumBeforeFirstUnacked < N) {
					this->receiverAckPkt[i] = this->receiverAckPkt[i + ackedNumBeforeFirstUnacked];
				}
				else
				{
					this->receiverAckPkt[i] = packet_init;
				}
			}

			cout << "==============" << endl;
			cout << "上交后：" << endl;
 			for (int i = 0; i < N; i++)
			{
				cout << this->receiverAckPkt[i].seqnum << "\t" << this->receiverAckPkt[i].payload << endl;
			}
		}
		else if ((this->expectSequenceNumberRcvd <= MAXID - N && seqNum > this->expectSequenceNumberRcvd && seqNum < this->expectSequenceNumberRcvd + N) || (this->expectSequenceNumberRcvd > MAXID - N && (seqNum > this->expectSequenceNumberRcvd || seqNum < (this->expectSequenceNumberRcvd + N) % MAXID)) && this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].acknum == -1)
		{
			pUtils->printPacket("接收方提前收到报文", packet);

			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N] = packet;
			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].acknum = packet.seqnum;
			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].seqnum = -1;

			pUtils->printPacket("接收方提前收到报文", receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);

			pUtils->printPacket("接收方发送确认报文", this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);
			pns->sendToNetworkLayer(SENDER, this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);	//调用模拟网络环境的sendToNetworkLayer，通过网络层发送确认报文到对方
		}
		else
		{
			Packet waste_packet = packet;
			waste_packet.acknum = packet.seqnum;
			waste_packet.seqnum = -1;
			pUtils->printPacket("接收方发送确认报文(重复)", waste_packet);
			pns->sendToNetworkLayer(SENDER, waste_packet);	//调用模拟网络环境的sendToNetworkLayer，通过网络层发送确认报文到对方
		}
	}
}
