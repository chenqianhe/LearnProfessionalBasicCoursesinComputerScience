#include "stdafx.h"
#include "Global.h"
#include "GBNSender.h"

bool GBNSender::getWaitingState()
{
	return waitingState;
}

bool GBNSender::send(const Message& message)
{
	if (this->waitingState) { //发送方处于等待确认状态
		return false;
	}

	this->packetWaitingAck[this->packetSentNumber].acknum = -1; //忽略该字段
	this->packetWaitingAck[this->packetSentNumber].seqnum = this->expectSequenceNumberSend;
	this->packetWaitingAck[this->packetSentNumber].checksum = 0;
	memcpy(this->packetWaitingAck[this->packetSentNumber].payload, message.data, sizeof(message.data));
	this->packetWaitingAck[this->packetSentNumber].checksum = pUtils->calculateCheckSum(this->packetWaitingAck[this->packetSentNumber]);
	pUtils->printPacket("发送方发送报文", this->packetWaitingAck[this->packetSentNumber]);
	pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetWaitingAck[this->packetSentNumber].seqnum);			//启动发送方定时器
	pns->sendToNetworkLayer(RECEIVER, this->packetWaitingAck[this->packetSentNumber]);								//调用模拟网络环境的sendToNetworkLayer，通过网络层发送到对方

	if (this->packetSentNumber == 0) {
		this->exceptedSeqNumber = this->expectSequenceNumberSend;
	}

	this->expectSequenceNumberSend = (this->expectSequenceNumberSend + 1) % MAXID;
	this->packetSentNumber++;
	if (this->packetSentNumber > 3) {
		this->waitingState = true;
	}																			//进入等待状态
	return true;
}

void GBNSender::receive(const Packet& ackPkt)
{
	int checkSum = pUtils->calculateCheckSum(ackPkt);

	if (checkSum == ackPkt.checksum) {
		int ackNum = ackPkt.acknum;
		if (((ackNum + 1) % MAXID) == this->exceptedSeqNumber) {
			// 失败时发送上一个， +1 跟期望相等即发送失败
			// 重传
			for (int i = 0; i < this->packetSentNumber; i++) {
				pns->stopTimer(SENDER, this->packetWaitingAck[i].seqnum);									//首先关闭定时器
				pns->startTimer(SENDER, Configuration::TIME_OUT, this->packetWaitingAck[i].seqnum);			//重新启动发送方定时器
				pns->sendToNetworkLayer(RECEIVER, this->packetWaitingAck[i]);								//重新发送数据包
			}
		}
		else {
			// 正确
			this->waitingState = false;
			pUtils->printPacket("发送方正确接受ACK", ackPkt);

			int numberAcked = (ackNum + MAXID - this->exceptedSeqNumber) % MAXID;
			//int numberAcked;
			//if (ackNum < this->exceptedSeqNumber) {
			//	numberAcked = ackNum + MAXID - this->exceptedSeqNumber;
			//}
			//else {
			//	numberAcked = ackNum - this->exceptedSeqNumber;
			//}

			cout << "==========" << endl;
			cout << "滑动前：\n" << endl;
			for (int i = 0; i < this->packetSentNumber; i++) {
				cout << this->packetWaitingAck[i].seqnum << "\t" << this->packetWaitingAck[i].payload << endl;
			}

			// 变更下一个确认号 
			this->exceptedSeqNumber = (this->exceptedSeqNumber + numberAcked + 1) % MAXID;
			// 更新分组内已发送数量
			this->packetSentNumber = this->packetSentNumber - (numberAcked + 1);

			for (int i = 0; i <= numberAcked; i++) {
				pns->stopTimer(SENDER, this->packetWaitingAck[i].seqnum);		//关闭定时器
			}

			for (int i = 0; i < this->packetSentNumber; i++) {
				this->packetWaitingAck[i] = this->packetWaitingAck[i + numberAcked + 1];
			}

			cout << "-+-+-+-+-+" << endl;

			cout << "滑动后：\n" << endl;
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
		pUtils->printPacket("发送方定时器时间到，重发上次发送的报文", this->packetWaitingAck[i]);
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

