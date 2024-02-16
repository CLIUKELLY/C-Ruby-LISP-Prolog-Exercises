
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct carModel
{
    char* model;
    char* km;
    char* type;
    char* transmission;
    char* stock;
    char* drivetrain;
    char* status;
    char* fueleconomy;
    char* year;
    char* trim;
    char* feature;
    //struct car *car_data;
    struct carModel *nextPtr; 
}model;

typedef struct carMaker
{
    char*  maker;
    struct carModel *carModel_data; 
    struct carMaker *nextPtr; 
}maker;

struct carModel *startModelNode;

//Function to convert into car model catalog
void createModelNodeList(char filename[20]);

//Function to display carModels
void displayModelNodeList(struct carModel* node);

struct carModel* addToCarModel(char* data);
struct carMaker* addToCarMaker(char* data);

int main(){
    printf("Read form file output.txt:");
    char maker[10];
    createModelNodeList("output.txt");
    //displayModelNodeList();
    
    return 0;
}

void createModelNodeList(char filename[20]){
    
    char szTest[10000] = {0};
    FILE *fp = fopen("output.txt", "r");  
    char * token;
    char *array;
    
    startModelNode = (struct carModel *)malloc(sizeof(struct carModel));
    
    //Read from listings.txt file and extract info
    if(startModelNode == NULL){
        printf("Memory cannot be allocated");
    }else{
        if(NULL == fp){          
            printf("failed to open output.txt\n");         
        }
        
        while(!feof(fp)){          
            memset(szTest,0, sizeof(szTest));
            fgets(szTest,sizeof(szTest) - 1, fp);
            printf("%s",szTest);    
            
            token = strtok(szTest,", ");
            //printf("------%s\n", token);
            addToCarModel(token);
            //displayModelNodeList(startModelNode);
            
            int counter=0;
            while (token != NULL && counter <=10)
            {
                printf("%s\n", token);
                if(counter<=9){
                    token = strtok(NULL, ", ");  
                }
                else{
                    token = strtok(NULL, "}"); 
                    printf("%s}\n", token);
                    break;
                }
                counter++;
            }
        }
        fclose(fp);  
        printf("\n");     
    }
}

void displayModelNodeList(struct carModel * node){
    struct carModel *tempModelNode = node;
    
    if(tempModelNode == NULL){
        printf("No data found in carModel list.");
    }
    else{
        //tempModelNode = startModelNode;
        //while(tempModelNode != NULL){
            //printf("Maker = %s\n", tempModelNode->maker);
            //tempModelNode = tempModelNode ->nextPtr;
        //}
        
        printf("\n");
        printf("Model: %s, ", tempModelNode->model);
        printf("Trim: %s, ", tempModelNode->trim);
        printf("Km: %s, ", tempModelNode->km);
        printf("Type: %s, ", tempModelNode->type);
        printf("Drivetrain: %s, ", tempModelNode->drivetrain);
        printf("Transmission: %s, ", tempModelNode->transmission);
        printf("Stock: %s, ", tempModelNode->stock);
        printf("Status: %s, ", tempModelNode->status);
        printf("Fuel Economy: %s, ", tempModelNode->fueleconomy);
        printf("Year: %s, ", tempModelNode->year);
        printf("Feature: %s, ", tempModelNode->feature); 
        printf("\n\n");
    }
}

struct carModel* addToCarModel(char* data){
    struct carModel *newModelNode = NULL;
    struct carModel *tempModelNode = NULL;
    struct carModel *startModelNode = NULL;

    //newModelNode = (struct carModel*)malloc(sizeof(struct carModel));
    tempModelNode = (struct carModel *)malloc(sizeof(struct carModel));
    tempModelNode->nextPtr = NULL;
    tempModelNode->model = data;
    if(startModelNode == NULL){
        //strcpy(startModelNode->maker, maker_input);
        startModelNode = tempModelNode;
    }
    else{
        newModelNode = startModelNode;
        while (newModelNode->nextPtr != NULL){
            newModelNode = newModelNode->nextPtr;
        }
        newModelNode->nextPtr = tempModelNode;
    }
    return startModelNode;
}

struct carMaker* addToCarMaker(char* data){
    struct carMaker *newMakerNode = NULL;
    struct carMaker *tempMakerNode = NULL;
    struct carMaker *startMakerNode = NULL;

    //newModelNode = (struct carModel*)malloc(sizeof(struct carModel));
    tempMakerNode = (struct carMaker *)malloc(sizeof(struct carMaker));
    tempMakerNode->nextPtr = NULL;
    tempMakerNode->maker = data;
    
    if(startMakerNode == NULL){
        //strcpy(startModelNode->maker, maker_input);
        startMakerNode = tempMakerNode;
    }
    else{
        newMakerNode = startMakerNode;
        while (newMakerNode->nextPtr != NULL){
            newMakerNode = newMakerNode->nextPtr;
        }
        newMakerNode->nextPtr = tempMakerNode;
    }
    return startMakerNode;
}