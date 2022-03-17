/********************************************************************************
** Form generated from reading UI file 'process1.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_PROCESS1_H
#define UI_PROCESS1_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_process1
{
public:
    QLabel *process1Text;

    void setupUi(QWidget *process1)
    {
        if (process1->objectName().isEmpty())
            process1->setObjectName(QString::fromUtf8("process1"));
        process1->resize(400, 300);
        process1Text = new QLabel(process1);
        process1Text->setObjectName(QString::fromUtf8("process1Text"));
        process1Text->setGeometry(QRect(130, 130, 129, 34));

        retranslateUi(process1);

        QMetaObject::connectSlotsByName(process1);
    } // setupUi

    void retranslateUi(QWidget *process1)
    {
        process1->setWindowTitle(QApplication::translate("process1", "Form", nullptr));
        process1Text->setText(QApplication::translate("process1", "TextLabel", nullptr));
    } // retranslateUi

};

namespace Ui {
    class process1: public Ui_process1 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PROCESS1_H
