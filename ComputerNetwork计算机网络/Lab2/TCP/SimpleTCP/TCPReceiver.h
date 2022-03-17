#pragma once
#ifndef TCPReceiver_H
#define TCPReceiver_H
#include "Global.h"
#include "stdafx.h"

#include "RdtReceiver.h"
class TCPReceiver :
    public RdtReceiver
{
private:
	int BaseNumber;	// 期待收到的下一个报文序号
	Packet packetsReceived[WINDOW_SIZE];	//已发送并等待Ack的数据包们

public:
	TCPReceiver();
	virtual ~TCPReceiver();
	void receive(const Packet& packet);	//接收报文，将被NetworkService调用
};

#endif 