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
	int expectSequenceNumberRcvd;	// �ڴ��յ�����һ���������
	Packet receiverAckPkt[N];				//�ϴη��͵�ȷ�ϱ���

public:
	SRReceiver();
	virtual ~SRReceiver();

public:

	void receive(const Packet& packet);	//���ձ��ģ�����NetworkService����
};

#endif