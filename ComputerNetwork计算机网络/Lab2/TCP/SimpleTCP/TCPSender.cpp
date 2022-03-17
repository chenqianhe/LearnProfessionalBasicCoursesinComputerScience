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
	this->packetsWaitingAck[this->packetSentNumber].acknum = -1; //忽略该字段
	this->packetsWaitingAck[this->packetSentNumber].seqnum = this->expectSequenceNumberSend;
	this->packetsWaitingAck[this->packetSentNumber].checksum = 0;
	memcpy(this->packetsWaitingAck[this->packetSentNumber].payload, message.data, sizeof(message.data));
	this->packetsWaitingAck[this->packetSentNumber].checksum = pUtils->calculateCheckSum(this->packetsWaitingAck[this->packetSentNumber]);
	pUtils->printPacket("发送方发送报文", this->packetsWaitingAck[this->packetSentNumber]);
	pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetsWaitingAck[this->packetSentNumber].seqnum);			//启动发送方定时器
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[this->packetSentNumber]);								//调用模拟网络环境的sendToNetworkLayer，通过网络层发送到对方

	if (this->packetSentNumber == 0) {
		this->expectedSeqNumber = this->expectSequenceNumberSend;
	}

	this->expectSequenceNumberSend = (this->expectSequenceNumberSend + 1) % MAXID;
	this->packetSentNumber++;
	if (this->packetSentNumber > 3) {
		this->waitingState = true;
	}																			//进入等待状态
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
				//满足上一条件---收到的确认帧的期望序号
				pUtils->printPacket("发送方正确收到确认", ackPkt);

				int number = 0;
				if (acknum > this->expectedSeqNumber)
					number = acknum - this->expectedSeqNumber;
				else
					number = acknum + MAXID - this->expectedSeqNumber;

				cout << "滑动前：\n" << endl;
				for (int i = 0; i < this->packetSentNumber; i++) {
					cout << "序号 " << this->packetsWaitingAck[i].seqnum << " 内容" << this->packetsWaitingAck[i].payload << endl;
				}



				for (int i = 0; i < WINDOW_SIZE; i++) {
					if (i < number) {
						pns->stopTimer(SENDER, this->packetsWaitingAck[i].seqnum);		//关闭定时器
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



				cout << "滑动后：\n" << endl;
				for (int i = 0; i < this->packetSentNumber; i++) {
					cout << "序号 " << this->packetsWaitingAck[i].seqnum << " 内容" << this->packetsWaitingAck[i].payload << endl;
				}

				cout << endl;

				this->waitingState = false;
			}
		}
		else {
			//收到丢失的冗余ACK
			if (this->repeatedACK == 3)
				this->repeatedACK = 1;
			else
				this->repeatedACK = this->repeatedACK + 1;

			pUtils->printPacket("发送方收到冗余ACK", ackPkt);
			cout << "第" << this->repeatedACK << "个" << endl;

			if (this->repeatedACK == 3 && this->packetSentNumber > 0) {
				//收到三个冗余ACK
				pUtils->printPacket("收到三个冗余ACK，重发对应的报文", this->packetsWaitingAck[0]);
				pns->stopTimer(SENDER, this->packetsWaitingAck[0].seqnum);												//首先关闭定时器
				pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetsWaitingAck[0].seqnum);					//重新启动发送方定时器
				pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[0]);			//重新发送数据包
			}
		}
	}
}

void TCPSender::timeoutHandler(int seqNum)
{
	this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID].acknum = -1;
	pUtils->printPacket("发送方定时器时间到，重发上次发送的报文", this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);
	pns->stopTimer(SENDER, seqNum);												//首先关闭定时器
	pns->startTimer(SENDER, Configuration::TIME_OUT, seqNum);					//重新启动发送方定时器
	pns->sendToNetworkLayer(RECEIVER, this->packetsWaitingAck[(seqNum - this->expectedSeqNumber + MAXID) % MAXID]);			//重新发送数据包
}

TCPSender::TCPSender():expectSequenceNumberSend(0), waitingState(false), packetSentNumber(0),expectedSeqNumber(1),repeatedACK(0)
{
}

TCPSender::~TCPSender()
{
}
