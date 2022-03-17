#include <stdio.h>
#include <string.h>

extern char rname[12] = { 0 };//{ "chenqianhe" };
extern char rpass[12] = { 0 };//{ "U201915160" };
char iname[50] = { 0 };
char ipass[50] = { 0 };

struct GOODS
{
    char GOODSNAME[10];
    short BUYPRICE;
    short SELLPRICE;
    short BUYNUM;
    short SELLNUM;
    short RATE;

};


int login() {
    printf("Please enter the account number:");
    scanf_s("%s", &iname, 50);
    printf("Please input a password:");
    scanf_s("%s", &ipass, 50);
    if (!strcmp(rname, iname)&&!strcmp(rpass, ipass))
    {
        return 1;
    }
    return 0;
}   

void showmenuC(){
	printf("                Commodity Backgroud Management System\n");
	printf("-----------------------------------------------------------------------\n");
	printf("   1.Find the specified product and display its information\n");
    printf("   2.Selling\n");
    printf("   3.Replenishment\n");
    printf("   4.Calculate the profit margin of goods\n");
    printf("   5.Display commodity information from high to low profit margin\n");
    printf("   6.Increase commodities\n");
    printf("   9.Sign out\n");
    printf("-----------------------------------------------------------------------\n");
}
void addgoodsC() {

    extern struct GOODS GAN[26];
    extern int GANUM;

    for (size_t i = 0; i < 10; i++)
    {
        GAN[GANUM - 4].GOODSNAME[i] = 0;
    }
    printf("Please enter a new product name:");
    scanf_s("%s", &GAN[GANUM - 4].GOODSNAME, 10);
 
    printf("Please enter the purchase price of the new product:");
    scanf_s("%d", &GAN[GANUM - 4].BUYPRICE);

    printf("Please enter the selling price of the new product:");
    scanf_s("%d", &GAN[GANUM - 4].SELLPRICE);

    printf("Please input the quantity of new products:");
    scanf_s("%d", &GAN[GANUM - 4].BUYNUM);

    printf("Please enter the quantity of new product sold:");
    scanf_s("%d", &GAN[GANUM - 4].SELLNUM);

    if (GAN[GANUM - 4].BUYNUM >= 0 && GAN[GANUM - 4].BUYPRICE > 0 && GAN[GANUM - 4].SELLNUM >= 0 &&
        GAN[GANUM - 4].SELLPRICE > GAN[GANUM - 4].BUYPRICE && GAN[GANUM - 4].SELLNUM <= GAN[GANUM - 4].BUYNUM)
    {
        GANUM++;
    }
    else
    {
        printf("ÐÅÏ¢´íÎó£¬Ìí¼ÓÊ§°Ü£¡\n");
    }


    //GAN[GANUM - 4].BUYPRICE = invalue;
    //GAN[GANUM - 4].CELLPRICE = outvalue;
    //GAN[GANUM - 4].BUYNUM = innum;
    //GAN[GANUM - 4].CELLNUM = outnum;
}

