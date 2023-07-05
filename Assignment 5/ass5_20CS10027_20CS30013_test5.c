int a=19,b=100;

int sum(int a,int b);
int mod(int a, int b);
int mod2(int a,int b);
int divide(int a,int b);

int mod(int a,int b)
{
	double ans=a%b;
	return ans;
}

int divide(int a,int b)
{
	int ans;
	if(b!=0)
		ans=a/b;
	else
		ans=-1;
	return ans;
}
int mod2(int a,int b)
{
	int ans;
	if(a>b)
		ans=a-divide(a,b);
	else
		ans=b-divide(a,b);
	return ans;
}

int main()
{
	int ar1[15][13];
	double ar2[91];
	double y;
	int z;
	int x,y,z,w;
	x = sum(a,b);
	y = mod(b,b);
	z = divide(a,b);
	w = mod2(a,b);
}
int sum(int a,int b)
{
	int ans=a+b;
	return ans;
}

