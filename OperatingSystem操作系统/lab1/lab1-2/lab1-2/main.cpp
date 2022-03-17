#include "mainwindow.h"
#include "process1.h"
#include "process2.h"
#include "process3.h"
#include<unistd.h>
#include <QApplication>

int main(int argc, char *argv[])
{
    int pid;
    if((pid = fork()) == 0){
        QApplication a(argc,argv);
        process1 w;
        w.setWindowTitle("Process 1");
        w.show();
        a.exec();
        exit(0);
    }
    if((pid = fork()) == 0){
        QApplication a(argc,argv);
        process2 w;
        w.setWindowTitle("Process 2");
        w.show();
        a.exec();
        exit(0);
    }
    if((pid = fork()) == 0){
        QApplication a(argc,argv);
        process3 w;
        w.setWindowTitle("Process 3");
        w.show();
        a.exec();
        exit(0);
    }
    QApplication a(argc, argv);
    MainWindow w;
    w.setWindowTitle("Main Process");
    w.show();

    return a.exec();
}
