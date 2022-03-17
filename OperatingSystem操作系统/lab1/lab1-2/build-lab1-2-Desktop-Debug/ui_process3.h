/********************************************************************************
** Form generated from reading UI file 'process3.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_PROCESS3_H
#define UI_PROCESS3_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_process3
{
public:
    QLabel *process3Text;

    void setupUi(QWidget *process3)
    {
        if (process3->objectName().isEmpty())
            process3->setObjectName(QString::fromUtf8("process3"));
        process3->resize(400, 300);
        process3Text = new QLabel(process3);
        process3Text->setObjectName(QString::fromUtf8("process3Text"));
        process3Text->setGeometry(QRect(140, 130, 129, 34));

        retranslateUi(process3);

        QMetaObject::connectSlotsByName(process3);
    } // setupUi

    void retranslateUi(QWidget *process3)
    {
        process3->setWindowTitle(QApplication::translate("process3", "Form", nullptr));
        process3Text->setText(QApplication::translate("process3", "TextLabel", nullptr));
    } // retranslateUi

};

namespace Ui {
    class process3: public Ui_process3 {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PROCESS3_H
