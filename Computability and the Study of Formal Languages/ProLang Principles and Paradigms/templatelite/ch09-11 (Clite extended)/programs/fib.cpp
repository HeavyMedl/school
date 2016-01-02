int fibonacci (int n) {
	int fib0, fib1, temp, k;
	fib0 = 0; fib1 = 1; k = n;
	while (k > 0) {
		temp = fib0;
		fib0 = fib1;
		fib1 = fib0 + temp;
	}
	return fib0;
}
int main () {
	int answer;
	answer = fibonacci(8);
}
