import java.util.Scanner;

public class partiallyfilled
{
  public static void main(String[] args)
  {
    Scanner in = new Scanner(System.in);
    
    final int VALUES_LENGTH = 100;
    double[] values = new double[VALUES_LENGTH];
    
    int valuesSize = 0;
    while (in.hasNextDouble()) {
      if (valuesSize < values.length)
      {
        values[valuesSize] = in.nextDouble();
        valuesSize++;
      }
    }
    for (int i = 0; i < valuesSize; i++) {
      if (i > 0) {
        System.out.print(" | "); }
      System.out.print(values[i]); }
    
    System.out.println("\n" + "Partially Filled Array Size: " + valuesSize);
  }
}