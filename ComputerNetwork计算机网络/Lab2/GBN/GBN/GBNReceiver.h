#pragma once
#ifndef GBNReceiver_H
#define GBNReceiver_H
#include "Global.h"
#include "stdafx.h"
#include "RdtReceiver.h"
class GBNReceiver :
    public RdtReceiver
{
private:
	int expectSequenceNumberRcvd;	// �ڴ��յ�����һ���������
	Packet lastAckPkt;				//�ϴη��͵�ȷ�ϱ���

public:
	GBNReceiver();
	virtual ~GBNReceiver();

public:

	void receive(const Packet& packet);	//���ձ��ģ�����NetworkService����
};

#endif