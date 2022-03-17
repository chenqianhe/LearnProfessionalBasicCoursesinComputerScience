#include "process3.h"
#include "ui_process3.h"
#include <QTimer>

process3::process3(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::process3)
{
    ui->setupUi(this);
    this->setFixedSize(this->width(), this->height());
    this->move(1400, 500);

    i = 100;
    ui->process3Text->setText(QString::number(0,10));

    QTimer *timer = new QTimer (this);
    connect(timer,SIGNAL(timeout()),this,SLOT(Update()));
    timer->start(1000);
}

void process3::Update()
{


    ui->process3Text->setText(QString::number(i,10));
    i = (i + 100) % 500;

}

process3::~process3()
{
    delete ui;
}
