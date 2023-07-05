void Gamma(int dan, int elements);
int huhuhuh(int int_var, int elements,int value);
int main();

void Gamma(int dan, int elements)
{
  dan = elements;
  dan = dan+1;
  return;
}

int huhuhuh(int int_var, int elements,int value)
{
  int i ,passes = 0 ;
  if(int_var>= value)
    passes++;
  return(passes);
}

int main()
{
  int n=3;
  for(int i=0;i<n;i++)
    i=i+1;
  if(n>=0)
  {
    int int_var=3;
    int result;
    Gamma(int_var,3);
    result = huhuhuh(int_var,4,3);
  }
  else
  {
    int int_var=11;
    int result;
    Gamma(int_var,11);
  }
}
