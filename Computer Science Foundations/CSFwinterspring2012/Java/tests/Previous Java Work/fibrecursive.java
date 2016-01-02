public class fibrecursive {
  public int fib(int n)
  {
    if (n == 0 || n == 1) {
      return n; }
    else {
      return fib(n-1) + fib(n-2); }
  }
  public static void main(String[] args) {
    fibrecursive test = new fibrecursive();
    System.out.println(test.fib(15));
    
  }
}