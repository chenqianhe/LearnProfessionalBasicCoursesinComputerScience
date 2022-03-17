#ifndef PROCESS3_H
#define PROCESS3_H

#include <QWidget>

namespace Ui {
class process3;
}

class process3 : public QWidget
{
    Q_OBJECT

public:
    explicit process3(QWidget *parent = nullptr);
    ~process3();

public slots:
    void Update();
private:
    Ui::process3 *ui;
    int i;
};

#endif // PROCESS3_H
