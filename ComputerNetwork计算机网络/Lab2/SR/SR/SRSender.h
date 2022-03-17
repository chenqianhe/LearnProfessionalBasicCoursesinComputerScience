#pragma once
#ifndef SRSender_H
#define SRSender_H
#include "Global.h"
#include "RdtSender.h"
#include"stdafx.h"
class SRSender :
    public RdtSender
{
private:
	int expectSequenceNumberSend;	// 下一个发送序号 
	bool waitingState;				// 是否处于等待Ack的状态
	Packet packetsWaitingAck[N];	//已发送并等待Ack的数据包们
	int expectedSeqNumber;			//期望收到的ACK序号
	int packetSentNumber;			//一个窗口内已发送的packet个数

public:

	bool getWaitingState();
	bool send(const Message& message);						//发送应用层下来的Message，由NetworkServiceSimulator调用,如果发送方成功地将Message发送到网络层，返回true;如果因为发送方处于等待正确确认状态而拒绝发送Message，则返回false
	void receive(const Packet& ackPkt);						//接受确认Ack，将被NetworkServiceSimulator调用	
	void timeoutHandler(int seqNum);					//Timeout handler，将被NetworkServiceSimulator调用

	SRSender();
	virtual ~SRSender();
};

#endif