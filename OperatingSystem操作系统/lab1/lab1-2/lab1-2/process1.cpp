#include "process1.h"
#include "ui_process1.h"
#include <QTimer>

process1::process1(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::process1)
{
    ui->setupUi(this);
    this->setFixedSize(this->width(), this->height());
    this->move(600, 500);

    i = 1;
    ui->process1Text->setText(QString::number(0,10));

    QTimer *timer = new QTimer (this);
    connect(timer,SIGNAL(timeout()),this,SLOT(Update()));
    timer->start(1000);


}

void process1::Update()
{


    ui->process1Text->setText(QString::number(i,10));
    i = (i + 1) % 5;

}

process1::~process1()
{
    delete ui;
}
