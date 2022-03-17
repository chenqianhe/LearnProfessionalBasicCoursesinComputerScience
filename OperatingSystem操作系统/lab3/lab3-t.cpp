#include <stdio.h>   
#include <sys/types.h>   
#include <sys/stat.h>   
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
int main()   
{   
	int myCharWR;   
	int i;   
	char buf[10];   
	myCharWR = open("/dev/charWR",O_RDWR);   
	if ( myCharWR == -1 )   
	{   
		printf("Can't open file \n");   
		exit(0);   
    }   
	read(myCharWR,buf,10);   
	for (i = 0; i < 10;i++)
	printf("%d\n",buf[i]);  
	close(myCharWR);   
}  
