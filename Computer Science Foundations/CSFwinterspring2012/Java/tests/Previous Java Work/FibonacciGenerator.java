import java.util.Scanner;

public class FibonacciGenerator
{
  private int f1;
  private int f2;
  
  public FibonacciGenerator()
  {
    f1 = 0;
    f2 = 1;
  }
  
  public int nextNumber()
  {
    int result;
    result = f1 + f2;
    f2 = f1;
    f1 = result;
    return result;
    
  }
  
}

  
      