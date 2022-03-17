#ifndef PROCESS2_H
#define PROCESS2_H

#include <QWidget>

namespace Ui {
class process2;
}

class process2 : public QWidget
{
    Q_OBJECT

public:
    explicit process2(QWidget *parent = nullptr);
    ~process2();

public slots:
    void Update();
private:
    Ui::process2 *ui;
    int i;
};

#endif // PROCESS2_H
