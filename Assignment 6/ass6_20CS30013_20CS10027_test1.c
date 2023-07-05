// Calculate Force 
int main()

{
    int force, mass, accelaration;
    prints("_____________ Calculating Force _____________\n");
    prints("Input the value of mass:");
    int err = 1;
    mass = readi(&err);
    prints("Input the value of accelaration:");
    accelaration = readi(&err);

    force = mass * accelaration;

    prints("The value of force is ");
    printi(force);
    prints("\n");
    prints("\n__________________________\n");
    return 0;

}