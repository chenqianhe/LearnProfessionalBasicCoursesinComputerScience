#ifndef MEM_H
#define MEM_H

#include <QWidget>
#include <QPainter>

namespace Ui {
class MEM;
}

class MEM : public QWidget
{
    Q_OBJECT

public:
    explicit MEM(QWidget *parent = nullptr);
    ~MEM();

private:
    Ui::MEM *ui;
    QImage image;
    int n;
    std::vector<int> a;

private slots:
    void Paint();

protected:
    void paintEvent(QPaintEvent *){
        QPainter painter(this);

        painter.drawImage(0,0,image);
    }
};

#endif // MEM_H
