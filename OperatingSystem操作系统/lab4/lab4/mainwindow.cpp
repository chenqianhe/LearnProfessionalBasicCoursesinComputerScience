#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "QTimer"
#include <QProcess>
#include <QFile>
#include <QMessageBox>
#include <QDateTime>
#include <sys/sysinfo.h>
#include <QDir>
#include <unistd.h>
#include <string>
#include <sstream>
#include <iostream>


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    usage = 0;
    ui->cpu_rate->setText(QString::number(usage,'f',10));

    QTimer* timer=new QTimer(this);

    connect(timer, SIGNAL(timeout()), this, SLOT(TabInfo()));
    TabInfo();
    showinfo(0);
    connect(timer, SIGNAL(timeout()), this, SLOT(Update()));

    connect(ui->pushButton_shutdown, SIGNAL(clicked()), this, SLOT(shutdown()));
    connect(ui->searchButton, SIGNAL(clicked()), this, SLOT(searchPID()));
    connect(ui->killButton, SIGNAL(clicked()), this, SLOT(killPID()));
    connect(ui->runButton, SIGNAL(clicked()), this, SLOT(Run()));

    cpu = new CPU;
    ui->CPUhorizontalLayout->addWidget(cpu);

    mem = new MEM;
    ui->MEMhorizontalLayout_2->addWidget(mem);

}

void MainWindow::Update()
{
    QProcess process;
    process.start("cat /proc/stat");
    process.waitForFinished();
    QString res = process.readLine();
    res.replace("\n","").replace(QRegExp("( ){1,}")," ");
    auto contents = res.split(" ");
    if(contents.size() > 3)
    {
        double use = contents[1].toDouble() + contents[2].toDouble() + contents[3].toDouble();
        double total = 0;
        for(int i = 1;i < contents.size();++i)
            total += contents[i].toDouble();
        if(total - cpuTotal > 0){
            usage = (use - cpuUsed) / (total - cpuTotal) * 100.0;
            ui->cpu_rate->setText(QString::number(usage,'f',10));
            cpuTotal = total;
            cpuUsed = use;
        }
    }
}

void MainWindow::TabInfo(){
    QFile tempFile;
    QDateTime time;
    QString tempStr;
    int pos;
    ui->label_CurrentTime->setText(time.currentDateTime().toString("yyyy")+"."+\
                                   time.currentDateTime().toString("M")+"."+\
                                   time.currentDateTime().toString("d")+" "+\
                                   time.currentDateTime().toString("h")+":"+\
                                   time.currentDateTime().toString("m")+":"+\
                                   time.currentDateTime().toString("s"));


    tempFile.close();
    tempFile.setFileName("/proc/meminfo");
    if ( !tempFile.open(QIODevice::ReadOnly) )
    {
        return;
    }
    QString memTotal;
    QString memFree;
    QString memUsed;
    int nMemTotal, nMemFree, nMemUsed;

    while (1)
    {
        tempStr = tempFile.readLine();
        pos = tempStr.indexOf("MemTotal");
        if (pos != -1)
        {
            memTotal = tempStr.mid(pos+10, tempStr.length()-13);
            memTotal = memTotal.trimmed();
            nMemTotal = memTotal.toInt()/1024;
        }
        else if (pos = tempStr.indexOf("MemFree"), pos != -1)
        {
            memFree = tempStr.mid(pos+9, tempStr.length()-12);
            memFree = memFree.trimmed();
            nMemFree = memFree.toInt()/1024;
            break;
        }
    }

    nMemUsed = nMemTotal - nMemFree;

    memUsed = QString::number(nMemUsed, 10);
    memFree = QString::number(nMemFree, 10);
    memTotal = QString::number(nMemTotal, 10);

    ui->progressBar_RAM->setValue(nMemUsed*100/nMemTotal);

    int index=ui->tabWidget_INFO->currentIndex();
    if(index==0){
        struct sysinfo info;
        sysinfo(&info);
        struct tm *ptm=nullptr;
        ptm=gmtime(&info.uptime);
        char time_buf[30];
        sprintf(time_buf,"%02d:%02d:%02d",ptm->tm_hour,ptm->tm_min,ptm->tm_sec);
        ui->label_runningtime->setText(QString(time_buf));
    }

    tempFile.close();
}

void MainWindow::showinfo(int index){
    QString tempStr; //读取文件信息字符串
    QFile tempFile; //用于打开系统文件
    int pos; //读取文件的位置
    if(index ==0){//SystemInfo
        tempFile.setFileName("/proc/cpuinfo");
        if ( !tempFile.open(QIODevice::ReadOnly) )
        {
            QMessageBox::warning(this, tr("warning"), tr("The cpuinfo file can not open!"), QMessageBox::Yes);
            return;
        }
        char hostname[30];
        gethostname(hostname,30);
        ui->label_hostname->setText(hostname);

        struct sysinfo info;
        time_t cur_time=0;
        time_t boot_time=0;
        struct tm *ptm=nullptr;
        if(sysinfo(&info)) return;
        time(&cur_time);
        boot_time=cur_time-info.uptime;
        ptm=localtime(&boot_time);
        char boottime_buf[30];
        sprintf(boottime_buf,"%d.%d.%d %02d:%02d:%02d",ptm->tm_year+1900,ptm->tm_mon+1,ptm->tm_mday,
                ptm->tm_hour,ptm->tm_min,ptm->tm_sec);
        ui->label_boottime->setText(QString(boottime_buf));


        while (1)
        {
            tempStr = tempFile.readLine();
            if (pos = tempStr.indexOf("model name"), pos != -1)
            {
                pos += 12;
                QString *cpu_type = new QString( tempStr.mid(pos, tempStr.length()-12) );
                ui->label_CPUType->setText(*cpu_type);
                break;
            }
        }
        tempFile.close();


        tempFile.setFileName("/proc/version");
        if ( !tempFile.open(QIODevice::ReadOnly) )
        {
            QMessageBox::warning(this, tr("warning"), tr("The version file can not open!"), QMessageBox::Yes);
            return ;
        }
        tempStr = tempFile.readLine();

        int pos1 = tempStr.indexOf("(");
        QString *os_type = new QString( tempStr.mid(14, pos1-pos-2) );
        ui->label_SystemVersion->setText(*os_type);

        tempFile.close(); //关闭操作系统信息文件
    }

    else if(index==1){//ProgInfo
        ui->listWidget_process->clear();
        QDir qd("/proc");
        QStringList qsList = qd.entryList();
        QString qs = qsList.join("\n");
        QString id_of_pro;
        bool ok;
        int find_start = 3;
        int a, b;
        int nProPid; //进程PID
        QString proName; //进程名
        QString proState; //PPID
        QString proPri; //进程优先级
        QString proMem; //进程占用内存
        QListWidgetItem *title = new QListWidgetItem("PID\t" + QString::fromUtf8("名称") + "\t\t" +
                                                     QString::fromUtf8("PPID") + "\t" +
                                                     QString::fromUtf8("优先级") + "\t" +
                                                     QString::fromUtf8("占用内存"), ui->listWidget_process);
        //循环读取进程
        while (1)
        {
            //获取进程PID
            a = qs.indexOf("\n", find_start);
            b = qs.indexOf("\n", a+1);
            find_start = b;
            id_of_pro = qs.mid(a+1, b-a-1);
            nProPid = id_of_pro.toInt(&ok, 10);
            if(!ok)
            {
                break;
            }

            //打开PID所对应的进程状态文件
            tempFile.setFileName("/proc/" + id_of_pro + "/stat");
            if ( !tempFile.open(QIODevice::ReadOnly) )
            {
                QMessageBox::warning(this, tr("warning"), tr("The pid stat file can not open!"), QMessageBox::Yes);
                return;
            }
            tempStr = tempFile.readLine();
            if (tempStr.length() == 0)
            {
                break;
            }
            a = tempStr.indexOf("(");
            b = tempStr.indexOf(")");
            proName = tempStr.mid(a+1, b-a-1);
            proName.trimmed(); //删除两端的空格
            proState = tempStr.section(" ", 3, 3);
            proPri = tempStr.section(" ", 17, 17);
            proMem = tempStr.section(" ", 22, 22);


            if (proName.length() >= 13)
            {
                QListWidgetItem *item = new QListWidgetItem(id_of_pro + "\t" +
                                                            proName + "\t" +
                                                            proState + "\t" +
                                                            proPri + "\t" +
                                                            proMem, ui->listWidget_process);
            }
            else
            {
                QListWidgetItem *item = new QListWidgetItem(id_of_pro + "\t" +
                                                            proName + "\t\t" +
                                                            proState + "\t" +
                                                            proPri + "\t" +
                                                            proMem, ui->listWidget_process);
            }
            tempFile.close();
        }

        tempFile.close(); //关闭该PID进程的状态文件

    }

    else if(index == 2) {

    }

}

void MainWindow::shutdown()
{
//    system("shutdown -h now");
    qDebug("1");
}

void MainWindow::on_tabWidget_INFO_currentChanged(int index)
{
    showinfo(index); //显示tab中的内容
    return;
}

void MainWindow::searchPID()
{
    QString pid_num = ui->pid->text();
    int a, b;
    QString tempStr; //读取文件信息字符串
    int nProPid; //进程PID
    QString proName; //进程名
    QString proState; //PPID
    QString proPri; //进程优先级
    QString proMem; //进程占用内存

    QFile tempFile; //用于打开系统文件

    tempFile.setFileName("/proc/" + pid_num + "/stat");
    if ( !tempFile.open(QIODevice::ReadOnly) )
    {
        QMessageBox::warning(this, tr("warning"), tr("The pid stat file can not open!"), QMessageBox::Yes);
        return;
    }
    tempStr = tempFile.readLine();
    if (tempStr.length() == 0)
    {
        return;
    }
    a = tempStr.indexOf("(");
    b = tempStr.indexOf(")");
    proName = tempStr.mid(a+1, b-a-1);
    proName.trimmed(); //删除两端的空格
    proState = tempStr.section(" ", 3, 3);
    proPri = tempStr.section(" ", 17, 17);
    proMem = tempStr.section(" ", 22, 22);

    ui->pidInfo->setText(pid_num + "\t" +
           proName + "\t" +
           proState + "\t" +
           proPri + "\t" +
           proMem);

    return;

}

void MainWindow::killPID()
{
    int pid_num = ui->pid->text().toInt();
    std::string command;
    std::stringstream ss;
    ss << pid_num;
    ss >> command;
    command = "kill -9 " + command;
//    system(command.c_str());
    qDebug(command.c_str());
}

void MainWindow::Run()
{
    QString path = ui->path->text();
    system(path.toStdString().c_str());
}

MainWindow::~MainWindow()
{
    delete ui;
}

