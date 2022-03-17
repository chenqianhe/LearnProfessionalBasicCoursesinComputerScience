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
	int expectSequenceNumberSend;	// ��һ��������� 
	bool waitingState;				// �Ƿ��ڵȴ�Ack��״̬
	Packet packetsWaitingAck[N];	//�ѷ��Ͳ��ȴ�Ack�����ݰ���
	int expectedSeqNumber;			//�����յ���ACK���
	int packetSentNumber;			//һ���������ѷ��͵�packet����

public:

	bool getWaitingState();
	bool send(const Message& message);						//����Ӧ�ò�������Message����NetworkServiceSimulator����,������ͷ��ɹ��ؽ�Message���͵�����㣬����true;�����Ϊ���ͷ����ڵȴ���ȷȷ��״̬���ܾ�����Message���򷵻�false
	void receive(const Packet& ackPkt);						//����ȷ��Ack������NetworkServiceSimulator����	
	void timeoutHandler(int seqNum);					//Timeout handler������NetworkServiceSimulator����

	SRSender();
	virtual ~SRSender();
};

#endif