
#include <stdio.h>
#include <stdlib.h>

//Method takes a two-dimensional array as its input argument then transposes its elements.
void matrixTranspose (int **row, int **col , int n, int m){

    for (int i=0; i<n; ++i)
        for (int j=0; j<m; ++j){
            col[j][i] = row[i][j]; 
            }

    printf ("The transposed 2-D matrix:\n");
    for (int k=0; k<m; k++){
        for (int l=0; l<n; l++){
            printf ("%d ",col[k][l]);
        }
        printf ("\n");
    }
}

int main(){
    int n,m; //n = row numeber; m = column number
    printf("Please define the \"row\" and \"column\" numbers of the 2-D matrix. (Use space in between):\n");
    scanf("%d%d",&n,&m);
    
    //Initial memory allocation for matrix
    int** row = (int**)malloc(n * sizeof(int*));
    int** col = (int**)malloc(m * sizeof(int*));  
    
    for (int i=0; i<n; i++)
        row[i] = (int*)malloc(m * sizeof(int)); 
  
    for (int i=0; i<m; i++)
        col[i] = (int*)malloc(n * sizeof(int)); 
  
    printf ("Please enter the 2-D matrix. (Use space in between every input):\n");

    for (int j=0; j<n; j++){
        for (int k=0; k<m; k++){
        scanf ("%d",&row[j][k]);
        }
    }

    matrixTranspose(row,col,n,m);
    
    for (int i = 0; i < n; i++){
        free(row[i]);
    }
    free(row);

    for (int i = 0; i < m; i++){
        free(col[i]);
    }
    free(col);
        
}
