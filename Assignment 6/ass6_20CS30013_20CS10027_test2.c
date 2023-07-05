// Convert decimal number to binary
int main()
{
    int N, binaryN, reverseBinaryN, tempN, numofDigits;
    reverseBinaryN = 0;
    binaryN = 0;
    prints("_____________ Convert Decimal Number to Binary ______________\n");
    prints("Input an integer: ");
    
    int err = 1;
    N = readi(&err);

    tempN = N;
    numofDigits = 0;

    while(tempN != 0)
    {
        numofDigits = numofDigits + 1;
        if(tempN%2==1)
            reverseBinaryN = reverseBinaryN*10 + 1;
        else
            reverseBinaryN = reverseBinaryN*10;

        tempN = tempN /2;
    }
    
    while( reverseBinaryN != 0 )
    {
        binaryN = binaryN*10 + reverseBinaryN%10;
        reverseBinaryN = reverseBinaryN/10;
        numofDigits = numofDigits - 1;
    }
    while(numofDigits != 0)
    {
        numofDigits = numofDigits - 1;
        binaryN = binaryN * 10;
    }
    prints("The binary representation of the integer is:");
    printi(binaryN);
    prints("\n");
    prints("\n_______________________________________________\n");
    
    return 0;
}