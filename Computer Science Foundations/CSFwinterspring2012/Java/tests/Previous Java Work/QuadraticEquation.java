public class QuadraticEquation
{
  private double a;
  private double b;
  private double c;
  
  public QuadraticEquation(double a1, double b1, double c1)
  {
    a = a1;
    b = b1;
    c = c1;
  }
  
  public double getSolution1()
  {
    double root = Math.sqrt(b * b - 4 * a * c);
    double x1 = (-b + root) / (2 * a);
    if (root < 0)
      x1 = 0;
    return x1;
  }
  
  public double getSolution2()
  {
    double root = Math.sqrt(b * b - 4 * a * c);
    double x2 = (-b - root) / (2 * a);
    if (root < 0)
      x2 = 0;
    return x2;
  }
  
  public boolean hasSolutions()
  {
    double root = Math.sqrt(b * b - 4 * a * c);
    return root > 0;
  }
  
  
  public static void main(String[] args)
  {
    QuadraticEquation test = new QuadraticEquation(2,5,3);
    System.out.println("Solution 1: " + test.getSolution1());
    System.out.println("Solution 2: " + test.getSolution2());
    System.out.println("Is the discriminant positive: " + test.hasSolutions());
  }
}

