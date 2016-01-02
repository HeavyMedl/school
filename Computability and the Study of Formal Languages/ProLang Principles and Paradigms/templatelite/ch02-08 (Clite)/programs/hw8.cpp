int main() {
    int i, a, z;
    i = 5;
    a = 2;
    z = 1;
    while (i > 0) {
	if (i-i/2*2==1)
	    z = z * a; 
	i = i/2;
	a = a * a;
	}
}
