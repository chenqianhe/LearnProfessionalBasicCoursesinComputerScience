#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    this->setFixedSize(this->width(), this->height());
    this->move(1000, 1000);

}

MainWindow::~MainWindow()
{
    delete ui;
}

