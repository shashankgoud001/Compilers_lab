#include "myl.h"
#define BUFF_SIZE 300

int printStr(char *input){
    char buffer[BUFF_SIZE];
    int l=0;
    for(l=0;l<BUFF_SIZE&&input[l]!='\0';++l){
        buffer[l] = input[l];
    }
    buffer[l] = '\0';
    l += 1;
    // if(input[l]!='\0') return ERR;
    __asm__ __volatile__ (				
	"movl $1, %%eax \n\t"				
	"movq $1, %%rdi \n\t"					
	"syscall \n\t"
	:										
	:"S"(buffer), "d"(l)				
	);
    return l;
}


int printInt(int n){
    // delcare variables
    int l,i,j;
    char buffer[BUFF_SIZE],c;
    // initialse the variables
    l = 0;
    i = 0;
    
    // check if the entered n is negative and append negative sign at start and change the sign
    if(n<0){
            buffer[l] = '-';
            l += 1;
            n = -n;
            i = 1;
    }
    // check if the entered n is 0 and store only single 0 in buffer
    if(n==0){
        buffer[l] = '0';
        l += 1;
    }
    else{
        // loop till n != 0, copying the digit of n from right side 
        while(n>0){
            buffer[l] = '0'+ n%10;
            l += 1;
            n /= 10;
        }
        j = l - 1;
        while(i<j){                 // swapping the starting and ending digits using two pointers
            c = buffer[j];
            buffer[j] = buffer[i];
            buffer[i] = c;
            i += 1;
            j -= 1;
        }
    }
    
    buffer[l] = '\0';             // storing null character at the end of char array

    l += 1;                   
    

    __asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buffer), "d"(l)
	) ; 
	l--;
    return l;
}


int printFlt(float f)
{
	// delcare variables

	char buffer[BUFF_SIZE];
	
	int l=0,i=0,j;

	    // initialse the variables

	int integral_part = f;
	float fractional_part = f - integral_part;
	
	// check if the entered n is negative and append negative sign at start and change the sign
	if(f<0){
			buffer[l]='-';
			fractional_part = -fractional_part;
			l += 1;
			i = 1;
			integral_part = -integral_part;
		}
	
	if(integral_part==0){
		buffer[l]='0';
        l+=1;
    }
	else{
		
		while(integral_part>0){
			buffer[l]= '0'+integral_part%10;
			integral_part/=10;
			l+=1;
		}
		j=l-1;
		while(i<j){
			char temp = buffer[i];
			buffer[i] = buffer[j];
			buffer[j] = temp;
			i+=1;
			j-=1;
		}
	}

		buffer[l]='.';
        l+=1;

		if(fractional_part == 0)
		{
			j = 0;
			while(j<6){
				j++;
				buffer[l] = '0';
            	l+=1;
			}
		}
		else{
			j = 0;
			int temp = (int)fractional_part;
			while(temp != fractional_part && j<6)
			{
				if(l==BUFF_SIZE) return ERR;
				fractional_part = fractional_part * 10; 
				buffer[l] = ((int)(fractional_part) + '0');
				temp = (int)fractional_part;
				fractional_part = fractional_part - temp;
				j++;
				l++;
			}
		}

		buffer[l] = '\0';
		l++;

    

	__asm__ __volatile__(
		"movl $1, %%eax\n\t"
		"movq $1, %%rdi\n\t"
		"syscall\n\t"
		:"=a"(j)
		:"S"(buffer), "d"(l)
		) ; 
	l--;
	if(j < 0)
		return ERR;
	else 
		return l; 

}



int readInt(int *n){
	// delcare variables
	char buffer[BUFF_SIZE]="";
	int j = 0,first=0,l,number=0,nonNumberFlag=0,enteredNumber=0;
	__asm__ __volatile(
		"movl $0,%%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:"=a"(l)
		:"S"(buffer),"d"(sizeof(buffer))
	);
	l--;

	while(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n'){
		j++;
        if(j==l) return ERR;
	}

	first = j;
	if(buffer[j] == '-')
	{
		j++;
		if(l == 1) return ERR;
	}
	while(j < l )
	{	
		if(buffer[j] >= '0' && buffer[j] <= '9')
		{
			number *= 10;
			number += buffer[j] - '0';
			j++;
			enteredNumber = 1;
		}
		else 
		{
			if(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n') break;
			nonNumberFlag = 1; 
			break;
		}
	}
	if(nonNumberFlag) return ERR;
	if(!enteredNumber) return ERR;
	if(buffer[first] == '-'){
		number = -number;
	}
		
		*n = number;
		return OK; 
}

int readFlt(float *f)
{
	// delcare variables
	int l,j=0,first=0,enteredNumber=0,nonNumberFlag=0,integer_part=0,decimal_count=0;
	char buffer[BUFF_SIZE]="";
	float fractional_part,number;
	__asm__ __volatile(
		"movl $0,%%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:"=a"(l)
		:"S"(buffer),"d"(sizeof(buffer))

		); 
	l--;

	while(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n'){
		j++;
        if(j==l) return ERR;
	}

	first = j;

	if(buffer[j] == '-')
	{
		j++;
		if(l == 1) return ERR;
	}
	while( j < l)
	{	
        if(buffer[j] == '.') break;
		if(buffer[j] >= '0' && buffer[j] <= '9')
		{
			integer_part *= 10;
			integer_part += buffer[j] - '0';
			j++;
			enteredNumber = 1;
		}
		else
		{
			if(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n') break;
			nonNumberFlag = 1;  
			break;
		}
	}
	if(buffer[j] == '.')
	{
		j++;
		while(j < l && decimal_count < 6)
		{
			if(buffer[j] >= '0' && buffer[j] <= '9')
			{
				fractional_part = fractional_part*10 + buffer[j] - '0';
				j++;
				decimal_count++;
				enteredNumber++;
			}
			else
			{
				if(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n') break;
				nonNumberFlag++; 
				break;
			}
		}
		while(decimal_count!=0)
		{
			fractional_part = fractional_part/10;
			decimal_count--;
		}
	}else if(buffer[j]==' '||buffer[j]=='\t'||buffer[j]=='\n'){
		fractional_part = 0;
	}else{
		return ERR;
	}
	if(nonNumberFlag) return ERR;
	if(!enteredNumber) return ERR;
	number = integer_part + fractional_part;
	if(buffer[first]=='-') number = -number;
	*f = number;

	return OK; 
}
