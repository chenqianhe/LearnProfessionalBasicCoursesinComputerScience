#pragma once
#ifndef GBNSender_H
#define GBNSender_H
#include "RdtSender.h"
#include "Global.h"

class GBNSender :
    public RdtSender
{
private:
	int expectSequenceNumberSend;	// ��һ��������� 
	bool waitingState;				// �Ƿ��ڵȴ�Ack��״̬
	int packetSentNumber;	//һ���������ѷ��͵�����
	Packet packetWaitingAck[WINDOW_SIZE];		//�ѷ��Ͳ��ȴ�Ack�����ݰ�
	int exceptedSeqNumber;	//�����յ���ACK

public:

	bool getWaitingState();
	bool send(const Message& message);						//����Ӧ�ò�������Message����NetworkServiceSimulator����,������ͷ��ɹ��ؽ�Message���͵�����㣬����true;�����Ϊ���ͷ����ڵȴ���ȷȷ��״̬���ܾ�����Message���򷵻�false
	void receive(const Packet& ackPkt);						//����ȷ��Ack������NetworkServiceSimulator����	
	void timeoutHandler(int seqNum);					//Timeout handler������NetworkServiceSimulator����

public:
	GBNSender();
	virtual ~GBNSender();
};

#endif