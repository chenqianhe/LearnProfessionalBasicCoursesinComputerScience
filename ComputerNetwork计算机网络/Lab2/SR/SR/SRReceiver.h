#pragma once
#ifndef SRReceiver_H

#define SRReceiver_H
#include "Global.h"
#include "stdafx.h"
#include "RdtReceiver.h"
class SRReceiver :
    public RdtReceiver
{
private:
	int expectSequenceNumberRcvd;	// 期待收到的下一个报文序号
	Packet receiverAckPkt[N];				//上次发送的确认报文

public:
	SRReceiver();
	virtual ~SRReceiver();

public:

	void receive(const Packet& packet);	//接收报文，将被NetworkService调用
};

#endif