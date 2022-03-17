#include "SRReceiver.h"

SRReceiver::SRReceiver():expectSequenceNumberRcvd(0)
{
	for (int i = 0; i < N; i++)
	{
		this->receiverAckPkt[i].acknum = -1;	//��ʼ״̬�£�ȷ�ϰ���ȷ�����Ϊ-1
		this->receiverAckPkt[i].seqnum = -1;	//���Ը��ֶ�
	}
}

SRReceiver::~SRReceiver()
{
}

void SRReceiver::receive(const Packet& packet)
{
	// ���У����Ƿ���ȷ
	int checkSum = pUtils->calculateCheckSum(packet);

	if (checkSum == packet.checksum)
	{
		int seqNum = packet.seqnum;

		pUtils->printPacket("���շ��յ����Ĵ�����", packet);

		if (seqNum == this->expectSequenceNumberRcvd)
		{
			this->receiverAckPkt[0] = packet;
			this->receiverAckPkt[0].acknum = packet.seqnum;
			this->receiverAckPkt[0].seqnum = -1;
			pUtils->printPacket("���շ�����ȷ�ϱ���", this->receiverAckPkt[0]);
			pns->sendToNetworkLayer(SENDER, this->receiverAckPkt[0]);	//����ģ�����绷����sendToNetworkLayer��ͨ������㷢��ȷ�ϱ��ĵ��Է�

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

			cout << "��һ����ţ�" << this->expectSequenceNumberRcvd << endl;

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
			cout << "�Ͻ���" << endl;
 			for (int i = 0; i < N; i++)
			{
				cout << this->receiverAckPkt[i].seqnum << "\t" << this->receiverAckPkt[i].payload << endl;
			}
		}
		else if ((this->expectSequenceNumberRcvd <= MAXID - N && seqNum > this->expectSequenceNumberRcvd && seqNum < this->expectSequenceNumberRcvd + N) || (this->expectSequenceNumberRcvd > MAXID - N && (seqNum > this->expectSequenceNumberRcvd || seqNum < (this->expectSequenceNumberRcvd + N) % MAXID)) && this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].acknum == -1)
		{
			pUtils->printPacket("���շ���ǰ�յ�����", packet);

			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N] = packet;
			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].acknum = packet.seqnum;
			this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N].seqnum = -1;

			pUtils->printPacket("���շ���ǰ�յ�����", receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);

			pUtils->printPacket("���շ�����ȷ�ϱ���", this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);
			pns->sendToNetworkLayer(SENDER, this->receiverAckPkt[(seqNum - this->expectSequenceNumberRcvd + MAXID) % N]);	//����ģ�����绷����sendToNetworkLayer��ͨ������㷢��ȷ�ϱ��ĵ��Է�
		}
		else
		{
			Packet waste_packet = packet;
			waste_packet.acknum = packet.seqnum;
			waste_packet.seqnum = -1;
			pUtils->printPacket("���շ�����ȷ�ϱ���(�ظ�)", waste_packet);
			pns->sendToNetworkLayer(SENDER, waste_packet);	//����ģ�����绷����sendToNetworkLayer��ͨ������㷢��ȷ�ϱ��ĵ��Է�
		}
	}
}
