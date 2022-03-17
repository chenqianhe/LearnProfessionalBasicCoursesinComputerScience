#include <stdio.h>   
#include <sys/types.h>   
#include <sys/stat.h>   
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
int main()   
{   
	int myCharWRNEW;   
	int i;   
	char buf[20];   
	char buf2[10];
	myCharWRNEW = open("/dev/charWRNEW",O_RDWR);   
	if ( myCharWRNEW == -1 )   
	{   
		printf("Can't open file \n");   
		exit(0);   
    }   
	for (i = 0; i < 10;i++) buf2[i] = 100;
	write(myCharWRNEW,buf2,10);
	read(myCharWRNEW,buf,20);   
	for (i = 0; i < 20;i++)
	printf("%d\n",buf[i]);
      
	close(myCharWRNEW);   
}  
