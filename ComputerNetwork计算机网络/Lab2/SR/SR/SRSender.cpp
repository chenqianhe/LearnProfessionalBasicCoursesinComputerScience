#include "SRSender.h"

bool SRSender::getWaitingState()
{
    return waitingState;
}

bool SRSender::send(const Message& message)
{
	if (this->waitingState)
	{
		return false;
	}

	this->packetsWaitingAck[this->packetSentNumber].acknum = -1;	//���Ը��ֶ�
	this->packetsWaitingAck[this->packetSentNumber].seqnum = this->expectSequenceNumberSend;
	this->packetsWaitingAck[this->packetSentNumber].checksum = 0;
	memcpy(this->packetsWaitingAck[this->packetSentNumber].payload, message.data, sizeof(message.data));
	this->packetsWaitingAck[this->packetSentNumber].checksum = pUtils->calculateCheckSum(this->packetsWaitingAck[this->packetSentNumber]);
	pUtils->printPacket("���ͷ����ͱ���", this->packetsWaitingAck[this->packetSentNumber]);
	pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetsWaitingAck[this->packetSentNumber].seqnum);			//�������ͷ���ʱ��
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[this->packetSentNumber]);								//����ģ�����绷����sendToNetworkLayer��ͨ������㷢�͵��Է�

	//��������seqnumber
	if (this->packetSentNumber == 0) {
		this->expectedSeqNumber = this->expectSequenceNumberSend;
	}

	this->expectSequenceNumberSend = (this->expectSequenceNumberSend + 1) % MAXID;
	this->packetSentNumber++;
	if (this->packetSentNumber > 3) {
		this->waitingState = true;
	}																			//����ȴ�״̬
	return true;
}

void SRSender::receive(const Packet& ackPkt)
{
	int checkSum = pUtils->calculateCheckSum(ackPkt);

	if (checkSum == ackPkt.checksum)
	{
		int ackNum = ackPkt.acknum;

		if (ackNum != this->expectedSeqNumber)
		{
			for (int i = 0; i < this->packetSentNumber; i++)
			{
				if (this->packetsWaitingAck[i].seqnum == ackNum)
				{
					this->packetsWaitingAck[i].acknum = ackNum;
					pns->stopTimer(SENDER, this->packetsWaitingAck[i].seqnum);
				}
			}
		}
		else
		{
			pUtils->printPacket("���ͷ���ȷ�յ�ȷ�ϱ���", ackPkt);
			this->packetsWaitingAck[0].acknum = ackPkt.acknum;
			pns->stopTimer(SENDER, this->packetsWaitingAck[0].seqnum);

			cout << "==========" << endl;
			cout << "����ǰ���ڣ�\n" << endl;
			for (int i = 0; i < this->packetSentNumber; i++) {
				cout << this->packetsWaitingAck[i].seqnum << endl;
				pUtils->printPacket("\t", this->packetsWaitingAck[i]);
			}

			int ackedNumBeforeFirstUnacked = 0;
			while (this->packetsWaitingAck[ackedNumBeforeFirstUnacked].acknum != -1 && ackedNumBeforeFirstUnacked < this->packetSentNumber)
			{
				ackedNumBeforeFirstUnacked++;

			}

			cout << "this->packetSentNumber:" << this->packetSentNumber << endl;
			cout << "ackedNumBeforeFirstUnacked:" << ackedNumBeforeFirstUnacked << endl;

			for (int i = 0; i < N; i++)
			{
				this->packetsWaitingAck[i] = this->packetsWaitingAck[(i + ackedNumBeforeFirstUnacked) % N];
				//if (i + ackedNumBeforeFirstUnacked < N)
				//{
				//	this->packetsWaitingAck[i] = this->packetsWaitingAck[i + ackedNumBeforeFirstUnacked];
				//}
				//else
				//{
				//	this->packetsWaitingAck[i].acknum = -1;
				//}
			}
			// cout << "expectedSeqNumber" << this->expectedSeqNumber << endl;
			this->expectedSeqNumber = (this->expectedSeqNumber + ackedNumBeforeFirstUnacked) % MAXID;
			// cout << "expectedSeqNumber" << this->expectedSeqNumber << endl;
			this->packetSentNumber -= ackedNumBeforeFirstUnacked;
			cout << "NEWthis->expectedSeqNumber:" << this->expectedSeqNumber << endl;
			cout << "NEWthis->packetSentNumber:" << this->packetSentNumber << endl;


			cout << "�����󴰿ڣ�\n" << endl;
			for (int i = 0; i < this->packetSentNumber; i++) {
				cout << this->packetsWaitingAck[i].seqnum << endl;
				pUtils->printPacket("\t", this->packetsWaitingAck[i]);
			}
			if (!this->packetSentNumber)
			{
				for (int i = 0; i < MAXID; i++)
				{
					pns->stopTimer(SENDER, i);
				}
			}


			cout << endl;
			cout << "==========" << endl;

			this->waitingState = false;


		}
	}
}

void SRSender::timeoutHandler(int seqNum)
{
	this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID].acknum = -1;
	pUtils->printPacket("���ͷ���ʱ��ʱ�䵽���ط��ϴη��͵ı���", this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);
	pns->stopTimer(SENDER, seqNum);												//���ȹرն�ʱ��
	pns->startTimer(SENDER, Configuration::TIME_OUT, seqNum);					//�����������ͷ���ʱ��
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);			//���·������ݰ�
}

SRSender::SRSender():expectSequenceNumberSend(0), waitingState(false), packetSentNumber(0), expectedSeqNumber(0)
{
	for (int i = 0; i < N; i++)
	{
		this->packetsWaitingAck[i].seqnum = -1;
		this->packetsWaitingAck[i].acknum = -1;
	}
}

SRSender::~SRSender()
{
}
