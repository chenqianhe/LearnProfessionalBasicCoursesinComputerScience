#include "stdafx.h"
#include "Global.h"
#include "GBNSender.h"

bool GBNSender::getWaitingState()
{
	return waitingState;
}

bool GBNSender::send(const Message& message)
{
	if (this->waitingState) { //���ͷ����ڵȴ�ȷ��״̬
		return false;
	}

	this->packetWaitingAck[this->packetSentNumber].acknum = -1; //���Ը��ֶ�
	this->packetWaitingAck[this->packetSentNumber].seqnum = this->expectSequenceNumberSend;
	this->packetWaitingAck[this->packetSentNumber].checksum = 0;
	memcpy(this->packetWaitingAck[this->packetSentNumber].payload, message.data, sizeof(message.data));
	this->packetWaitingAck[this->packetSentNumber].checksum = pUtils->calculateCheckSum(this->packetWaitingAck[this->packetSentNumber]);
	pUtils->printPacket("���ͷ����ͱ���", this->packetWaitingAck[this->packetSentNumber]);
	pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetWaitingAck[this->packetSentNumber].seqnum);			//�������ͷ���ʱ��
	pns->sendToNetworkLayer(RECEIVER, this->packetWaitingAck[this->packetSentNumber]);								//����ģ�����绷����sendToNetworkLayer��ͨ������㷢�͵��Է�

	if (this->packetSentNumber == 0) {
		this->exceptedSeqNumber = this->expectSequenceNumberSend;
	}

	this->expectSequenceNumberSend = (this->expectSequenceNumberSend + 1) % MAXID;
	this->packetSentNumber++;
	if (this->packetSentNumber > 3) {
		this->waitingState = true;
	}																			//����ȴ�״̬
	return true;
}

void GBNSender::receive(const Packet& ackPkt)
{
	int checkSum = pUtils->calculateCheckSum(ackPkt);

	if (checkSum == ackPkt.checksum) {
		int ackNum = ackPkt.acknum;
		if (((ackNum + 1) % MAXID) == this->exceptedSeqNumber) {
			// ʧ��ʱ������һ���� +1 ��������ȼ�����ʧ��
			// �ش�
			for (int i = 0; i < this->packetSentNumber; i++) {
				pns->stopTimer(SENDER, this->packetWaitingAck[i].seqnum);									//���ȹرն�ʱ��
				pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetWaitingAck[i].seqnum);			//�����������ͷ���ʱ��
				pns->sendToNetworkLayer(RECEIVER, this->packetWaitingAck[i]);								//���·������ݰ�
			}
		}
		else {
			// ��ȷ
			this->waitingState = false;
			pUtils->printPacket("���ͷ���ȷ����ACK", ackPkt);

			int numberAcked = (ackNum + MAXID - this->exceptedSeqNumber) % MAXID;
			//int numberAcked;
			//if (ackNum < this->exceptedSeqNumber) {
			//	numberAcked = ackNum + MAXID - this->exceptedSeqNumber;
			//}
			//else {
			//	numberAcked = ackNum - this->exceptedSeqNumber;
			//}

			cout << "==========" << endl;
			cout << "����ǰ��\n" << endl;
			for (int i = 0; i < this->packetSentNumber; i++) {
				cout << this->packetWaitingAck[i].seqnum << "\t" << this->packetWaitingAck[i].payload << endl;
			}

			// �����һ��ȷ�Ϻ� 
			this->exceptedSeqNumber = (this->exceptedSeqNumber + numberAcked + 1) % MAXID;
			// ���·������ѷ�������
			this->packetSentNumber = this->packetSentNumber - (numberAcked + 1);

			for (int i = 0; i <= numberAcked; i++) {
				pns->stopTimer(SENDER, this->packetWaitingAck[i].seqnum);		//�رն�ʱ��
			}

			for (int i = 0; i < this->packetSentNumber; i++) {
				this->packetWaitingAck[i] = this->packetWaitingAck[i + numberAcked + 1];
			}

			cout << "-+-+-+-+-+" << endl;

			cout << "������\n" << endl;
			for (int i = 0; i < this->packetSentNumber; i++) {
				cout << this->packetWaitingAck[i].seqnum << "\t" << this->packetWaitingAck[i].payload << endl;
			}

			cout << "==========" << endl;

		}
	}
}

void GBNSender::timeoutHandler(int seqNum)
{
	for (int i = 0; i < this->packetSentNumber; i++)
	{
		pUtils->printPacket("���ͷ���ʱ��ʱ�䵽���ط��ϴη��͵ı���", this->packetWaitingAck[i]);
		pns->stopTimer(SENDER, (seqNum + i) % MAXID);										
		pns->startTimer(SENDER, Configuration::TIME_OUT, (seqNum + i) % MAXID);			
		pns->sendToNetworkLayer(RECEIVER, this->packetWaitingAck[i]);
	}
}

GBNSender::GBNSender() :expectSequenceNumberSend(0), waitingState(false), exceptedSeqNumber(0), packetSentNumber(0)
{
}

GBNSender::~GBNSender()
{
}

