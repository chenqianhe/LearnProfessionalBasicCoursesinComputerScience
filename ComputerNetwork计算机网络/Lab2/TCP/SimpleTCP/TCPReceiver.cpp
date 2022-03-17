#include "TCPReceiver.h"

TCPReceiver::TCPReceiver():BaseNumber(0)
{
	for (int i = 0; i < WINDOW_SIZE; i++) {
		this->packetsReceived[i].acknum = -1;	//��ʼ״̬�£�ȷ�ϰ���ȷ�����Ϊ-1
		this->packetsReceived[i].seqnum = -1;	//���Ը��ֶ�
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

	//���У����Ƿ���ȷ
	int checkSum = pUtils->calculateCheckSum(packet);

	if (checkSum == packet.checksum)
	{
		int acknum = packet.seqnum;

		if (acknum == this->BaseNumber) {
			//�յ����������
			this->packetsReceived[0] = packet;
			this->packetsReceived[0].acknum = packet.seqnum;
			this->packetsReceived[0].seqnum = -1;

			int number = 0;
			Message msg;
			while (this->packetsReceived[number].acknum != -1) {
				//ȡ��Message�����ϵݽ���Ӧ�ò�
				memcpy(msg.data, this->packetsReceived[number].payload, sizeof(this->packetsReceived[number].payload));
				pns->delivertoAppLayer(RECEIVER, msg);
				number = number + 1;
				if (number == WINDOW_SIZE)
					break;
			}
			//���½��մ���
			for (int i = 0; i < WINDOW_SIZE; i++) {
				if (i < (WINDOW_SIZE - number))
					this->packetsReceived[i] = this->packetsReceived[i + number];
				else
					this->packetsReceived[i] = packet_init;
			}

			this->BaseNumber = (this->BaseNumber + number) % MAXID;

			packet_init.acknum = this->BaseNumber;
			packet_init.checksum = pUtils->calculateCheckSum(packet_init);
			pUtils->printPacket("���շ�����ȷ�ϱ���", packet_init);
			pns->sendToNetworkLayer(SENDER, packet_init);	//����ģ�����绷����sendToNetworkLayer��ͨ������㷢��ȷ�ϱ��ĵ��Է�

		}
		else {
			if (((this->BaseNumber + WINDOW_SIZE - 1) < MAXID) ? ((acknum > this->BaseNumber) && (acknum <= this->BaseNumber + WINDOW_SIZE - 1)) : ((acknum > this->BaseNumber) || (acknum <= ((this->BaseNumber + WINDOW_SIZE - 1) % MAXID)))) {
				//�յ������������õ����
				int serial = 0;
				if (acknum < this->BaseNumber)
					serial = acknum + MAXID - this->BaseNumber;
				else
					serial = acknum - this->BaseNumber;

				this->packetsReceived[serial] = packet;
				this->packetsReceived[serial].acknum = packet.seqnum;
				this->packetsReceived[serial].seqnum = -1;
			}

			//��������ACK
			packet_init.acknum = this->BaseNumber;
			packet_init.checksum = pUtils->calculateCheckSum(packet_init);
			pUtils->printPacket("���շ���������ACK", packet_init);
			pns->sendToNetworkLayer(SENDER, packet_init);	//����ģ�����绷����sendToNetworkLayer��ͨ������㷢��ȷ�ϱ��ĵ��Է�
		}
	}
}
