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
	int BaseNumber;	// �ڴ��յ�����һ���������
	Packet packetsReceived[WINDOW_SIZE];	//�ѷ��Ͳ��ȴ�Ack�����ݰ���

public:
	TCPReceiver();
	virtual ~TCPReceiver();
	void receive(const Packet& packet);	//���ձ��ģ�����NetworkService����
};

#endif 