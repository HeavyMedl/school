import java.util.Scanner;

public class FibonacciRunner
{
  public static void main(String[] args)
  {
    
    System.out.println("Enter n: ");
    
    FibonacciGenerator fg = new FibonacciGenerator();
    Scanner in = new Scanner(System.in);
    int n = in.nextInt();
    for (int i = 0; i < n; i++)
      System.out.println(fg.nextNumber());
  }
}