#include "TCPSender.h"

bool TCPSender::getWaitingState()
{
	return waitingState;
}

bool TCPSender::send(const Message& message)
{
	if (this->waitingState)
	{
		return false;
	}
	this->packetsWaitingAck[this->packetSentNumber].acknum = -1; //���Ը��ֶ�
	this->packetsWaitingAck[this->packetSentNumber].seqnum = this->expectSequenceNumberSend;
	this->packetsWaitingAck[this->packetSentNumber].checksum = 0;
	memcpy(this->packetsWaitingAck[this->packetSentNumber].payload, message.data, sizeof(message.data));
	this->packetsWaitingAck[this->packetSentNumber].checksum = pUtils->calculateCheckSum(this->packetsWaitingAck[this->packetSentNumber]);
	pUtils->printPacket("���ͷ����ͱ���", this->packetsWaitingAck[this->packetSentNumber]);
	pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetsWaitingAck[this->packetSentNumber].seqnum);			//�������ͷ���ʱ��
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[this->packetSentNumber]);								//����ģ�����绷����sendToNetworkLayer��ͨ������㷢�͵��Է�

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

void TCPSender::receive(const Packet& ackPkt)
{
	int checkSum = pUtils->calculateCheckSum(ackPkt);
	if (checkSum == ackPkt.checksum) {
		int acknum = ackPkt.acknum;
		if (acknum != this->expectedSeqNumber) {
			this->repeatedACK = 1;
			if (((this->expectedSeqNumber + WINDOW_SIZE) < MAXID) ? ((acknum > this->expectedSeqNumber) && (acknum <= this->expectedSeqNumber + WINDOW_SIZE)) : ((acknum > this->expectedSeqNumber) || (acknum <= ((this->expectedSeqNumber + WINDOW_SIZE) % MAXID)))) {
				//������һ����---�յ���ȷ��֡���������
				pUtils->printPacket("���ͷ���ȷ�յ�ȷ��", ackPkt);

				int number = 0;
				if (acknum > this->expectedSeqNumber)
					number = acknum - this->expectedSeqNumber;
				else
					number = acknum + MAXID - this->expectedSeqNumber;

				cout << "����ǰ��\n" << endl;
				for (int i = 0; i < this->packetSentNumber; i++) {
					cout << "��� " << this->packetsWaitingAck[i].seqnum << " ����" << this->packetsWaitingAck[i].payload << endl;
				}



				for (int i = 0; i < WINDOW_SIZE; i++) {
					if (i < number) {
						pns->stopTimer(SENDER, this->packetsWaitingAck[i].seqnum);		//�رն�ʱ��
					}
					if (i < (WINDOW_SIZE - number)) {
						this->packetsWaitingAck[i] = this->packetsWaitingAck[i + number];
					}
					else
					{
						this->packetsWaitingAck[i].acknum = -1;
						this->packetsWaitingAck[i].seqnum = -1;
					}
				}

				this->expectedSeqNumber = acknum;
				this->packetSentNumber = this->packetSentNumber - number;



				cout << "������\n" << endl;
				for (int i = 0; i < this->packetSentNumber; i++) {
					cout << "��� " << this->packetsWaitingAck[i].seqnum << " ����" << this->packetsWaitingAck[i].payload << endl;
				}

				cout << endl;

				this->waitingState = false;
			}
		}
		else {
			//�յ���ʧ������ACK
			if (this->repeatedACK == 3)
				this->repeatedACK = 1;
			else
				this->repeatedACK = this->repeatedACK + 1;

			pUtils->printPacket("���ͷ��յ�����ACK", ackPkt);
			cout << "��" << this->repeatedACK << "��" << endl;

			if (this->repeatedACK == 3 && this->packetSentNumber > 0) {
				//�յ���������ACK
				pUtils->printPacket("�յ���������ACK���ط���Ӧ�ı���", this->packetsWaitingAck[0]);
				pns->stopTimer(SENDER, this->packetsWaitingAck[0].seqnum);												//���ȹرն�ʱ��
				pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetsWaitingAck[0].seqnum);					//�����������ͷ���ʱ��
				pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[0]);			//���·������ݰ�
			}
		}
	}
}

void TCPSender::timeoutHandler(int seqNum)
{
	this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID].acknum = -1;
	pUtils->printPacket("���ͷ���ʱ��ʱ�䵽���ط��ϴη��͵ı���", this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);
	pns->stopTimer(SENDER, seqNum);												//���ȹرն�ʱ��
	pns->startTimer(SENDER, Configuration::TIME_OUT, seqNum);					//�����������ͷ���ʱ��
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);			//���·������ݰ�
}

TCPSender::TCPSender():expectSequenceNumberSend(0), waitingState(false), packetSentNumber(0),expectedSeqNumber(1),repeatedACK(0)
{
}

TCPSender::~TCPSender()
{
}
