/********************************************************************************
** Form generated from reading UI file 'mem.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MEM_H
#define UI_MEM_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MEM
{
public:

    void setupUi(QWidget *MEM)
    {
        if (MEM->objectName().isEmpty())
            MEM->setObjectName(QString::fromUtf8("MEM"));
        MEM->resize(400, 300);

        retranslateUi(MEM);

        QMetaObject::connectSlotsByName(MEM);
    } // setupUi

    void retranslateUi(QWidget *MEM)
    {
        MEM->setWindowTitle(QApplication::translate("MEM", "Form", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MEM: public Ui_MEM {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MEM_H
