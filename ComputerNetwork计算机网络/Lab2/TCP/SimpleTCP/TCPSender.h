#pragma once
#ifndef TCPSender_H
#define TCPSender_H

#include "Global.h"
#include "stdafx.h"

#include "RdtSender.h"
class TCPSender :
    public RdtSender
{
private:
	int expectSequenceNumberSend;	// ��һ��������� 
	bool waitingState;				// �Ƿ��ڵȴ�״̬
	Packet packetsWaitingAck[WINDOW_SIZE];	//�ѷ��Ͳ��ȴ�Ack�����ݰ���
	int expectedSeqNumber;			//�����յ���ACK���
	int packetSentNumber;			//һ���������ѷ��͵�packet����
	int repeatedACK;				//			

public:

	bool getWaitingState();
	bool send(const Message& message);						//����Ӧ�ò�������Message����NetworkServiceSimulator����,������ͷ��ɹ��ؽ�Message���͵�����㣬����true;�����Ϊ���ͷ����ڵȴ���ȷȷ��״̬���ܾ�����Message���򷵻�false
	void receive(const Packet& ackPkt);						//����ȷ��Ack������NetworkServiceSimulator����	
	void timeoutHandler(int seqNum);					//Timeout handler������NetworkServiceSimulator����
	TCPSender();
	virtual ~TCPSender();
};

#endif 