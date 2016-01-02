import java.util.Scanner;

public class PairTester
{
  public static void main(String[] args)
  {
    Scanner in = new Scanner(System.in);
    
    Pair thepair = new Pair();
    System.out.print("Enter first number:  ");
    double numberOne = in.nextDouble();
    
    System.out.print("Enter second number:  ");
    double numberTwo = in.nextDouble();
    thepair.newValue(numberOne, numberTwo);
    
    System.out.println("The Sum:  " + thepair.getSum());
    System.out.println("The Difference:  " + thepair.getDifference());
    System.out.println("The Product:  " + thepair.getProduct());
    System.out.println("The Average:  " + thepair.getAverage());
    System.out.println("The Distance:  " + thepair.getDistance());
    System.out.println("The Maximum:  " + thepair.getLarger());
    System.out.println("The Minimum:  " + thepair.getSmaller());
  }
}