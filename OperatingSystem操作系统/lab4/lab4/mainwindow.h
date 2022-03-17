#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "cpu.h"
#include "mem.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    QList<float> yList;
    QList<float> yList1;
    CPU *cpu;
    MEM *mem;

private slots:
    void showinfo(int index);
    void shutdown();
    void on_tabWidget_INFO_currentChanged(int index);
    void TabInfo();
    void Update();
    void searchPID();
    void killPID();
    void Run();
private:
    double usage;
    double cpuTotal = 0;
    double cpuUsed = 0;

};
#endif // MAINWINDOW_H
