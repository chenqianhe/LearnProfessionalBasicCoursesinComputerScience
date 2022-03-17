#ifndef CPU_H
#define CPU_H

#include <QWidget>
#include <QPainter>

namespace Ui {
class CPU;
}

class CPU : public QWidget
{
    Q_OBJECT

public:
    explicit CPU(QWidget *parent = nullptr);
    ~CPU();

private:
    Ui::CPU *ui;
    QImage image;
    int n;
    std::vector<int> a;

private slots:
    void Paint();

protected:
    void paintEvent(QPaintEvent *){
        QPainter painter(this);

        painter.drawImage(0,0,image);
    }
private:
    double usage;
    double cpuTotal = 0;
    double cpuUsed = 0;

};

#endif // CPU_H
