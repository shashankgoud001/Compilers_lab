int main();
int mul(int a,int b);
int mul(int a,int b){
int c = 0;
 for(int i = 0;i < b;i++) c = c+a;
 return c;
}
int main(){
int a = 10;
int b = 5;
return mul(a,b);
}
