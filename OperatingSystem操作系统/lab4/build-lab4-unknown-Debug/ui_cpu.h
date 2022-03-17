/********************************************************************************
** Form generated from reading UI file 'cpu.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CPU_H
#define UI_CPU_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_CPU
{
public:

    void setupUi(QWidget *CPU)
    {
        if (CPU->objectName().isEmpty())
            CPU->setObjectName(QString::fromUtf8("CPU"));
        CPU->resize(400, 300);

        retranslateUi(CPU);

        QMetaObject::connectSlotsByName(CPU);
    } // setupUi

    void retranslateUi(QWidget *CPU)
    {
        CPU->setWindowTitle(QApplication::translate("CPU", "Form", nullptr));
    } // retranslateUi

};

namespace Ui {
    class CPU: public Ui_CPU {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CPU_H
