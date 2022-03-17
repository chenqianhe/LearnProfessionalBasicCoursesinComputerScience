#include "process2.h"
#include "ui_process2.h"
#include <QTimer>

process2::process2(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::process2)
{
    ui->setupUi(this);
    this->setFixedSize(this->width(), this->height());
    this->move(1000, 500);

    i = 10;
    ui->process2Text->setText(QString::number(0,10));

    QTimer *timer = new QTimer (this);
    connect(timer,SIGNAL(timeout()),this,SLOT(Update()));
    timer->start(1000);
}

void process2::Update()
{


    ui->process2Text->setText(QString::number(i,10));
    i = (i + 10) % 50;

}

process2::~process2()
{
    delete ui;
}
