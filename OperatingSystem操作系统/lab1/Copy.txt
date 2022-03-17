#include <stdio.h>
#include <fcntl.h>
#include <cstring>
#include <unistd.h>

int main(int argc, char *argv[]){

    if(argc == 3){
        int oriFile, newFile, ret;

        if((oriFile = open(argv[1], O_RDONLY)) < 0){
            return -1;
        }
        if((newFile = open(argv[2], O_WRONLY|O_CREAT, 0755)) < 0){
            close(oriFile);
            return -1;
        }

        char buf[1024] = "";
        do{
            memset(buf,0,sizeof(buf));
            ret = read(oriFile, buf, sizeof(buf));
            if(ret > 0)
                write(newFile, buf, ret);
        }while(ret > 0);

        close(oriFile);
        close(newFile);
    }

    return 0;
}

