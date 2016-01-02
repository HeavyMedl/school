import java.util.Scanner;

public class StandardDeviation {

  
  public static void main(String[] args)
  {
    Scanner s = new Scanner(System.in);
    
    double d;
    double sqsum = 0;
    double sum = 0;
    int n = 0;
    
    System.out.println("Enter a range of values, 0 to quit");
    d = s.nextDouble();
    while (d > 0) {
      sum = sum + d;
      sqsum = sqsum + d * d;
      n++; 
     d = s.nextDouble();}
    
    double standarddeviation = Math.sqrt(sqsum - 1/n * (sum * sum) / (n-1));
    double theaverage = (sum / n);
    
    System.out.println("Count of the values: " + n);
    System.out.println("Average of the values: " + theaverage);
    System.out.println("Standard Deviation of Values: " + standarddeviation);
    
    // Implement the standard deviation
    
  }
}