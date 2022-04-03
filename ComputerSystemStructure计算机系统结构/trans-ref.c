/* 
 * trans.c - 矩阵转置B=A^T
 *每个转置函数都必须具有以下形式的原型：
 *void trans（int M，int N，int a[N][M]，int B[M][N]）；
 *通过计算，块大小为32字节的1KB直接映射缓存上的未命中数来计算转置函数。
 */ 
#include <stdio.h>
#include "cachelab.h"
int is_transpose(int M, int N, int A[N][M], int B[M][N]);
char transpose_submit_desc[] = "Transpose submission";  //请不要修改“Transpose_submission”


void transpose_submit(int M, int N, int A[N][M], int B[M][N])
{

//                          请在此处添加代码
//*************************************Begin********************************************************
    if (M==32 && N==32) {
        for (int i=0;i<M;i+=8) {
            for (int j=0;j<N;j++) {
                int temp1 = A[j][i];
                int temp2 = A[j][i+1];
                int temp3 = A[j][i+2];
                int temp4 = A[j][i+3];
                int temp5 = A[j][i+4];
                int temp6 = A[j][i+5];
                int temp7 = A[j][i+6];
                int temp8 = A[j][i+7];
                B[i][j] = temp1;
                B[i+1][j] = temp2;
                B[i+2][j] = temp3;
                B[i+3][j] = temp4;
                B[i+4][j] = temp5;
                B[i+5][j] = temp6;
                B[i+6][j] = temp7;
                B[i+7][j] = temp8;
            }
        }
    }
    if (M==64 && N==64) {
        for (int i=0;i<M;i+=8) {
            for (int j=0;j<N;j+=8) {
                for (int k=i;k<i+4;k++) {
                    int temp1 = A[k][j];
                    int temp2 = A[k][j+1];
                    int temp3 = A[k][j+2];
                    int temp4 = A[k][j+3];
                    int temp5 = A[k][j+4];
                    int temp6 = A[k][j+5];
                    int temp7 = A[k][j+6];
                    int temp8 = A[k][j+7];
                    B[j][k] = temp1;
                    B[j+1][k] = temp2;
                    B[j+2][k] = temp3;
                    B[j+3][k] = temp4;
                    B[j][k+4] = temp5;
                    B[j+1][k+4] = temp6;
                    B[j+2][k+4] = temp7;
                    B[j+3][k+4] = temp8;
                }
                for (int l=j;l<j+4;l++) {
                    int temp1 = A[i+4][l];
                    int temp2 = A[i+5][l];
                    int temp3 = A[i+6][l];
                    int temp4 = A[i+7][l];
                    int temp5 = B[l][i+4];
                    int temp6 = B[l][i+5];
                    int temp7 = B[l][i+6];
                    int temp8 = B[l][i+7];
                    B[l][i+4] = temp1;
                    B[l][i+5] = temp2;
                    B[l][i+6] = temp3;
                    B[l][i+7] = temp4;
                    B[l+4][i] = temp5;
                    B[l+4][i+1] = temp6;
                    B[l+4][i+2] = temp7;
                    B[l+4][i+3] = temp8;
                }
                for (int m=i+4;m<i+8;m++) {
                    int temp1 = A[m][j+4];
                    int temp2 = A[m][j+5];
                    int temp3 = A[m][j+6];
                    int temp4 = A[m][j+7]; 
                    B[j+4][m] = temp1;
                    B[j+5][m] = temp2;
                    B[j+6][m] = temp3;
                    B[j+7][m] = temp4;
                } 
            }
        }
    }
    if (M==61) {
        for (int i=0;i<M;i+=17) {
            for (int j=0;j<N;j+=17) {
                for (int k=i;k<i+17&&k<N;k++) {
                    for (int m=j;m<j+17&&m<M;m++) {
                        B[m][k] = A[k][m];
                    }
                }
            }
        }
    }



//**************************************End**********************************************************
}

/* 
 * 我们在下面定义了一个简单的方法来帮助您开始，您可以根据下面的例子把上面值置补充完整。
 */ 

/* 
 * 简单的基线转置功能，未针对缓存进行优化。
 */
char trans_desc[] = "Simple row-wise scan transpose";
void trans(int M, int N, int A[N][M], int B[M][N])
{
    int i, j, tmp;

    for (i = 0; i < N; i++) {
        for (j = 0; j < M; j++) {
            tmp = A[i][j];
            B[j][i] = tmp;
        }
    }    

}

/*
 * registerFunctions-此函数向驱动程序注册转置函数。
 *在运行时，驱动程序将评估每个注册的函数并总结它们的性能。这是一种试验不同转置策略的简便方法。
 */
void registerFunctions()
{
    /* 注册解决方案函数  */
    registerTransFunction(transpose_submit, transpose_submit_desc); 

    /* 注册任何附加转置函数 */
    registerTransFunction(trans, trans_desc); 

}

/* 
 * is_transpose - 函数检查B是否是A的转置。在从转置函数返回之前，可以通过调用它来检查转置的正确性。
 */
int is_transpose(int M, int N, int A[N][M], int B[M][N])
{
    int i, j;

    for (i = 0; i < N; i++) {
        for (j = 0; j < M; ++j) {
            if (A[i][j] != B[j][i]) {
                return 0;
            }
        }
    }
    return 1;
}

