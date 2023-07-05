int main();
int GCD_fun (int x, int y, int z);
void main()  
{  
    
    int n1, n2, n3;  
    
    int GCD;  
      
    for ( GCD = GCD_fun( n1, n2, n3); GCD >= 1; GCD--)  
    {  
        if (n1 % GCD == 0 && n2 % GCD == 0 && n3 % GCD == 0)  
        {  
            break;  
        }  
    }  
    
}  
  
int GCD_fun ( int x, int y, int z)  
{  
    if ( x >= y && x >= z)  
    {  
        return x;  
    }  
      
    else if ( y >= x && y >= z)  
    {  
        return y;  
    }  
      
    else if ( z >= x && z >= y)  
    {  
        return z;  
    }  
}  
