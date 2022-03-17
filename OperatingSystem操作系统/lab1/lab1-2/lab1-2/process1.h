#ifndef PROCESS1_H
#define PROCESS1_H

#include <QWidget>

namespace Ui {
class process1;
}

class process1 : public QWidget
{
    Q_OBJECT

public:
    explicit process1(QWidget *parent = nullptr);
    ~process1();
public slots:
    void Update();
private:
    Ui::process1 *ui;
    int i;
};

#endif // PROCESS1_H
