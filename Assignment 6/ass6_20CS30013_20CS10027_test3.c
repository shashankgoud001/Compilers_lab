//Largest sum contiguous subarray

int maxSubArraySum(int arr[], int size)       // Recursive function that will return the sum 
{
    int max_so_far = -1000000000;
    int max_ending_here = 0;
    int i;

    for(i = 0 ; i < size ; i++)
    {
        max_ending_here = max_ending_here + arr[i];

        if(max_so_far < max_ending_here)
            max_so_far = max_ending_here;

        if(max_ending_here < 0)
            max_ending_here = 0;
    }

    return max_so_far;
}

int main()
{
    int i,n;
    int arr[100];
    prints("\n************* Largest sum contiguous subarray ***********\n");


    prints("\nEnter size of array less than 100\n"); 
    int err=1;
    n=readi(&err);
    
    prints("\nEnter the elements of the first array one by one\n");
    for(i=0;i<n;i++)
    {
        arr[i]=readi(&err);
    }

    int s;
    s = maxSubArraySum(arr, n);
    
    prints("\nLargest sum contiguous subarray is: ");
    printi(s);
    
    prints("\n\n*************************************\n");
    return 0;
}