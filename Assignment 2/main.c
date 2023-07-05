#include "myl.h"

void readPrintInt(){
    int temp;
    printStr("\nEnter an integer : ");
    int flag = readInt(&temp);
    if(flag){
        printStr("\nEntered integer is ");
        flag = printInt(temp);
        printStr("\n\n");
        if(!flag){
            printStr("Error in printing Integer\n\n");
        }
    }else{
        printStr("\nYou have entered an invalid input\n\n");
    }
}

void readPrintFloat(){
    float temp;
    printStr("\nEnter a floating point : ");
    int flag = readFlt(&temp);
    if(flag){
        printStr("\nEntered floating point number is ");

        flag = printFlt(temp);

        printStr("\n\n");
        if(!flag){
            printStr("Error in printing a Floating Point\n\n");
        }
    }else{
        printStr("\nYou have entered an invalid input\n\n");
    }
}
int main(){
    int choice,flag = 1;
    while(flag){
        printStr("Select one option from below : \n");
        printStr("1. Read and Print an Integer\n");
        printStr("2. Read and Print a Floating point number\n");
        printStr("3. Exit\n");
        printStr("Enter your choice : ");
        readInt(&choice);
        switch (choice)
        {
        case 1:
            readPrintInt();
            break;
        case 2:
            readPrintFloat();
            break;
        case 3:
            flag = 0;
            break;
        default:
            printStr("\nPlease Enter a valid input\n\n");
            break;
        }
    }
    return 0;
}