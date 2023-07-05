int keekek(int a, int b);
int wooo(int a,int b,int c);
int YO(int a,int b, int c);
double great(int a,int b,int c,int d);

int keekek(int a,int b)
{
	return 90;
}
int YO(int a,int b, int c)
{
	wooo(a,b,c);
	keekek(a,b);
	return 4;
}
double great(int a,int b,int c,int d)
{
	wooo(a,b,c);
	keekek(a,b);
	YO(a,b,c);
	return 100.2;
}
int wooo(int a,int b,int c)
{
	keekek(a,b);
	return 91;
}

int main()
{
	int a=63,b=27,c=48,d=39;
	great(a,b,c,d);
	return 0;
}

