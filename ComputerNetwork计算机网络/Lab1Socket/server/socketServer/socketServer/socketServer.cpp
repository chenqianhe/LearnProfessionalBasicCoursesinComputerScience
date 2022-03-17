#define _CRT_SECURE_NO_WARNINGS
#pragma once
#include "winsock2.h"
#include <WS2tcpip.h>
//#include <stdio.h>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include "tinyxml.h"
#include "tinystr.h"

using namespace std;

#pragma comment(lib,"ws2_32.lib")

// 读取配置信息
void readConfiguration(string& configIp, int& configPort, string& configPath) {
    // 读取配置信息
    //创建一个XML的文档对象。
    TiXmlDocument* myDocument = new TiXmlDocument("configuration.xml");
    myDocument->LoadFile();
    //获得根元素，即WatchedInfo
    TiXmlElement* RootElement = myDocument->RootElement();
    //输出根元素名称。
    // cout << RootElement->Value() << endl;
    //获得节点。
    TiXmlElement* ipElement = RootElement->FirstChildElement();
    TiXmlElement* portElement = ipElement->NextSiblingElement();
    TiXmlElement* pathElement = portElement->NextSiblingElement();

    configIp = ipElement->FirstChild()->Value();
    configPort = atoi(string(portElement->FirstChild()->Value()).c_str());
    configPath = pathElement->FirstChild()->Value();
}
// 检查IP是否合法
bool ipLegalCheck(string ip) {
    int countOfPoint = 0;
    int pointLocation[3] = {0, 0, 0};
    for (size_t i = 0; i < ip.length(); i++)
    {
        if (ip[i] == '.')
        {
            pointLocation[countOfPoint++] = i;
        }
    }
    if (countOfPoint != 3 || ip.length() > 15)
    {
        return false;
    }

    if (atoi(ip.substr(0, pointLocation[0]).c_str()) > 255 || atoi(ip.substr(0, pointLocation[0]).c_str()) < 0 || 
        atoi(ip.substr(pointLocation[0]+1, pointLocation[1] - pointLocation[0] - 1).c_str()) > 255 || 
        atoi(ip.substr(pointLocation[0] + 1, pointLocation[1] - pointLocation[0] - 1).c_str()) < 0 ||
        atoi(ip.substr(pointLocation[1] + 1, pointLocation[2] - pointLocation[1] - 1).c_str()) > 255 ||
        atoi(ip.substr(pointLocation[1] + 1, pointLocation[2] - pointLocation[1] - 1).c_str()) < 0 ||
        atoi(ip.substr(pointLocation[2] + 1).c_str()) > 255 || atoi(ip.substr(pointLocation[2] + 1).c_str()) < 0
        )
    {
        return false;
    }
    return true;
}
// 检查端口是否合法
bool portLegalCheck(int port) {
    if (port < 1 || port > 65535)
    {
        return false;
    }
    return true;
}
// 获取客户端链接请求方法和地址
void getFilePath(char* recvBuf, int length, string& method, string& path) {
    int index = 0;
    for (int i = 0; i < length; i++)
    {
        if (recvBuf[i] != ' ')
        {
            method.push_back(recvBuf[i]);
        }
        else {
            index = i + 1;
            break;
        }
    }
    for (int i = index; i < length; i++)
    {
        if (recvBuf[i] != ' ')
        {
            path.push_back(recvBuf[i]);
        }
        else {
            path = "." + path;
            break;
        }
    }
}
// 查看打印客户端信息并返回是否请求文件
bool checkClientInfo(int rtn, char* recvBuf, string method, string path) {
    cout << "===========================" << endl;
    printf("Received %d bytes from client: %s\n\n", rtn, recvBuf);
    cout << "===========================" << endl;

    vector<string> methods(8);

    methods.push_back("GET");
    methods.push_back("POST");
    methods.push_back("HEAD");
    methods.push_back("DELETE");
    methods.push_back("CONNECT");
    methods.push_back("OPTIONS");
    methods.push_back("OPTIONS");
    methods.push_back("TRACE");

    for (int i = 0; i < methods.size(); i++)
    {
        if (method == methods[i])
        {
            cout << "method: " << method << endl << "FilePath: " << path << endl << endl;
            cout << "===========================" << endl;
            return true;
        }
    }
    return false;
}
// 处理报文返回内容
void sendInfo(SOCKET& sessionSocket, string path, string watchPath) {
    if (path.find(watchPath) != string::npos && path != watchPath)
    {
        FILE* fp;
        char ch;
        if ((fp = fopen(path.c_str(), "rb")) == NULL) {
            printf("\nCannot open file strike any key exit!");
            string header = "HTTP/1.1 404 NOT FOUND\r\n\r\n";
            send(sessionSocket, header.c_str(), header.length(), 0);

            cout << "===========================" << endl;
            cout << "响应失败！文件不存在！" << endl;
            cout << "===========================" << endl;
        }
        else {

            fseek(fp, 0, SEEK_END);
            int sendlen = ftell(fp);
            //printf("len1=%d\n",len1);
            fseek(fp, 0, SEEK_SET);
            char* sendbuf = (char*)malloc(sendlen + 1);
            ZeroMemory(sendbuf, sendlen + 1);
            fread(sendbuf, sendlen, 1, fp);

            string header = "HTTP/1.1 200 OK\r\n\r\n";
            // 回复报文
            send(sessionSocket, header.c_str(), header.length(), 0);
            send(sessionSocket, sendbuf, sendlen, 0);

            cout << "===========================" << endl;
            cout << "响应成功！" << endl;
            cout << "===========================" << endl;

            fclose(fp);
        }
    }
    else {
        string header = "HTTP/1.1 403 Forbidden\r\n\r\n";
        send(sessionSocket, header.c_str(), header.length(), 0);
        cout << "===========================" << endl;
        cout << "无权访问！" << endl;
        cout << "===========================" << endl;
    }
}


int main() {

    string configIp;
    int configPort;
    string configPath;
    readConfiguration(configIp, configPort, configPath);

    WSADATA wsaData;
    fd_set rfds;				//用于检查socket是否有数据到来的的文件描述符，用于socket非阻塞模式下等待网络事件通知（有数据到来）
    fd_set wfds;				//用于检查socket是否可以发送的文件描述符，用于socket非阻塞模式下等待网络事件通知（可以发送数据）
    bool first_connetion = true;

    // 完成初始化
    int nRc = WSAStartup(0x0202, &wsaData);

    // 判断初始化是否成功
    if (nRc)printf("Winsock  startup failed with error!\n");

    // 判断版本是否支持
    if (wsaData.wVersion != 0x0202) {
        printf("Winsock version is not correct!\n");
    }

    printf("Winsock  startup Ok!\n");

    // 创建socket
    SOCKET srvSocket;
    sockaddr_in addr, clientAddr;
    SOCKET sessionSocket;
    int addrLen;
    //创建socket服务，使用Internet地址，流类型，自动选择协议
    srvSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (srvSocket != INVALID_SOCKET)
        printf("Socket create Ok!\n\n");

    // 设置IP和端口
    string ip = configIp;
    while (!ipLegalCheck(ip))
    {
        cout << "Illegal IP configuration!" << endl;
        cout << "Pleaes input IP address:";
        cin >> ip;
    }

    int port = configPort;
    while (!portLegalCheck(port)) {
        cout << "Illegal PORT configuration!" << endl;
        cout << "Pleaes input port number(1-65535, it will be random if you input 0, so we refuse 0):";
        cin >> port;
    }

    // 设置监控目录
    string watchPath = configPath;
    // cout << "Please input watched path:";
    // cin >> watchPath;

    cout << "===========================" << endl;
    cout << "server address: " << ip << ":" << port << endl;
    cout << "Watched Path: " << watchPath << endl << endl;
    cout << "===========================" << endl;

    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);    // htons调节主机字节顺序为网络字节顺讯
    // addr.sin_addr.S_un.S_addr = htonl(INADDR_ANY);  // htonl调节主机字节顺序为网络字节顺序
    inet_pton(AF_INET, ip.c_str(), (void*)&(addr.sin_addr.S_un.S_addr)); // inet_pton是新API，将十进制地址转换为二进制存入指定位置


    // 绑定
    int rtn = bind(srvSocket, (LPSOCKADDR)&addr, sizeof(addr));
    if (rtn != SOCKET_ERROR)
        printf("Socket bind Ok!\n");

    // 监听， 等待队列长度5
    rtn = listen(srvSocket, 5);
    if (rtn != SOCKET_ERROR)
        printf("Socket listen Ok!\n");

    clientAddr.sin_family = AF_INET;
    addrLen = sizeof(clientAddr);
    char recvBuf[40960];

    u_long blockMode = 1;// 将srvSock设为非阻塞模式以监听客户连接请求

    if ((rtn = ioctlsocket(srvSocket, FIONBIO, &blockMode) == SOCKET_ERROR)) { // FIONBIO：允许或禁止套接口s的非阻塞模式。
        cout << "ioctlsocket() failed with error!\n";
        return -1;
    }
    cout << "ioctlsocket() for server socket ok!	Waiting for client connection and data\n";

    //清空read,write描述符，对rfds和wfds进行了初始化，必须用FD_ZERO先清空，下面才能FD_SET
    FD_ZERO(&rfds);
    FD_ZERO(&wfds);

    //设置等待客户连接请求
    FD_SET(srvSocket, &rfds);

    while (true) {
        //清空read,write描述符
        FD_ZERO(&rfds);
        FD_ZERO(&wfds);

        //设置等待客户连接请求
        FD_SET(srvSocket, &rfds);

        if (!first_connetion) {
            //设置等待会话SOKCET可接受数据或可发送数据
            FD_SET(sessionSocket, &rfds);
            FD_SET(sessionSocket, &wfds);
        }

        //开始等待
        int nTotal = select(0, &rfds, &wfds, NULL, NULL);

        //如果srvSock收到连接请求，接受客户连接请求
        if (FD_ISSET(srvSocket, &rfds)) {
            nTotal--;

            //产生会话SOCKET
            sessionSocket = accept(srvSocket, (LPSOCKADDR)&clientAddr, &addrLen);
            if (sessionSocket != INVALID_SOCKET)
                printf("Socket listen one client request!\n");

            // 打印客户IP
            char clientIp[20];
            inet_ntop(AF_INET, (void*)&(clientAddr.sin_addr), clientIp, 16);
            cout << "ClientIP: " << clientIp << endl << endl;

            //把会话SOCKET设为非阻塞模式
            rtn = ioctlsocket(sessionSocket, FIONBIO, &blockMode);
            if (rtn == SOCKET_ERROR) { //FIONBIO：允许或禁止套接口s的非阻塞模式。
                cout << "ioctlsocket() failed with error!\n";
                return -1;
            }
            cout << "ioctlsocket() for session socket ok!	Waiting for client connection and data\n \n";

            //设置等待会话SOKCET可接受数据或可发送数据
            FD_SET(sessionSocket, &rfds);
            FD_SET(sessionSocket, &wfds);

            first_connetion = false;

        }

        // 检查会话SOCKET是否有数据到来
        if (nTotal > 0) {
            if (FD_ISSET(sessionSocket, &rfds)) {
                memset(recvBuf, '\0', 4096);

                if ((rtn = recv(sessionSocket, recvBuf, 256, 0)) > 0) {
                    // 获取请求方法和请求文件路径
                    string method, path;
                    getFilePath(recvBuf, 4096, method, path);
                    // 查看客户端信息
                    bool REQ = checkClientInfo(rtn, recvBuf, method, path);
                    if (REQ)
                    {
                        // 处理请求
                        sendInfo(sessionSocket, path, watchPath);
                    }

                }
                else {
                    printf("Client leaving ...\n");
                    closesocket(sessionSocket);  //既然client离开了，就关闭sessionSocket
                    first_connetion = true;
                }
            }
        }
    }


    return 0;
}
