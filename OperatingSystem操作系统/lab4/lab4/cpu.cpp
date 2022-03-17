#include "cpu.h"
#include "ui_cpu.h"
#include "QTimer"
#include "QProcess"

CPU::CPU(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::CPU)
{
    ui->setupUi(this);
    image = QImage(300,300,QImage::Format_RGB32);  //画布的初始化大小设为600*500，使用32位颜色
    QColor backColor = qRgb(255,255,255);    //画布初始化背景色使用白色
    image.fill(backColor);//对画布进行填充
    QTimer* timer=new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(Paint()));
    Paint();
    timer->start(1000);
}

void CPU::Paint()
{
    QProcess process;
    process.start("cat /proc/stat");
    process.waitForFinished();
    QString res = process.readLine();
    res.replace("\n","").replace(QRegExp("( ){1,}")," ");
    auto contents = res.split(" ");
    if(contents.size() > 3)
    {
        double use = contents[1].toDouble() + contents[2].toDouble() + contents[3].toDouble();
        double total = 0;
        for(int i = 1;i < contents.size();++i)
            total += contents[i].toDouble();
        if(total - cpuTotal > 0){
            usage = (use - cpuUsed) / (total - cpuTotal) * 100.0;
            a.push_back(usage);
            cpuTotal = total;
            cpuUsed = use;
        }
    }

    n = a.size();

    if (a.size() > 120) {
        for (int i = 0;i < n-120; i++) {
            a.erase(a.begin());
        }
        n = 120;
    }

    image = QImage(300,300,QImage::Format_RGB32);  //画布的初始化大小设为600*500，使用32位颜色
    QColor backColor = qRgb(255,255,255);    //画布初始化背景色使用白色
    image.fill(backColor);//对画布进行填充
    QPainter painter(&image);



    painter.setRenderHint(QPainter::Antialiasing, true);//设置反锯齿模式，好看一点
    int pointx=20, pointy=260;
    int width=300-pointx, height=260;


//    painter.drawRect(5,5,300-10,300-10);//外围的矩形，从(5,5)起，到(590,290)结束，周围留了5的间隙
    painter.drawLine(pointx,pointy,width+pointx,pointy);//坐标轴x宽度为width
    painter.drawLine(pointx,pointy-height,pointx,pointy);//坐标轴y高度为height


    int _ma = 0;
    for (int i=0;i<n;i++) {
        if(a[i] > _ma){
            _ma = a[i];
        }
    }
    double kx=(double)width/(n-1);//x轴的系数
    double ky=(double)(height-10)/_ma;//y方向的比例系数
    if(n<2){
        return;
    }
    QPen pen,penPoint;
    pen.setColor(Qt::black);
    pen.setWidth(2);
    penPoint.setColor(Qt::blue);
    penPoint.setWidth(5);

    for(int i=0;i<n-1;i++)
    {
        //由于y轴是倒着的，所以y轴坐标要pointy-a[i]*ky 其中ky为比例系数
        painter.setPen(pen);//黑色笔用于连线
        painter.drawLine(pointx+kx*i,pointy-a[i]*ky,pointx+kx*(i+1),pointy-a[i+1]*ky);
        painter.setPen(penPoint);//蓝色的笔，用于标记各个点
        painter.drawPoint(pointx+kx*i,pointy-a[i]*ky);
    }

    painter.drawPoint(pointx+kx*(n-1),pointy-a[n-1]*ky);//绘制最后一个点

    //绘制刻度线

    QPen penDegree;
    penDegree.setColor(Qt::black);
    penDegree.setWidth(2);
    painter.setPen(penDegree);

    //画上x轴刻度线
    for(int i=0;i<10;i++)//分成10份
    {
        //选取合适的坐标，绘制一段长度为4的直线，用于表示刻度
        painter.drawLine(pointx+(i+1)*width/10,pointy,pointx+(i+1)*width/10,pointy+4);
        painter.drawText(pointx+(i+0.65)*width/10,
                         pointy+10,QString::number(((i+1)*((double)n/10))));
    }

    //y轴刻度线
    double _maStep=(double)_ma/10;//y轴刻度间隔需根据最大值来表示
    for(int i=0;i<10;i++)
    {
        //主要就是确定一个位置，然后画一条短短的直线表示刻度。
        painter.drawLine(pointx,pointy-(i+1)*height/10,
                         pointx-4,pointy-(i+1)*height/10);
        painter.drawText(pointx-20,pointy-(i+0.85)*height/10,
                         QString::number((_maStep*(i+1))));
    }


    update(); // updatePaint

}


CPU::~CPU()
{
    delete ui;
}
