import java.util.ArrayList;

public class arrayListmain
{
  public static void main(String[] args)
  {
    // ArrayList Sum
    double total = 0;
    ArrayList<Integer> sum = new ArrayList<Integer>();
    for (int i = 0; i < 15; i++) {
      sum.add(i);
      total = total + i; }
    // Array List Average
    double average = total / sum.size();

    System.out.println("Size: " + sum.size());
    
    // Get entirety of ArrayList "sum"
    System.out.println(sum);
    // Get element with index 2 of ArrayList
    System.out.println(sum.get(2));
    System.out.println(total);
    System.out.println(average);
    
    // Partition each element in ArrayList and place separator inbetween each element
    for (int i = 0; i < sum.size(); i++) {
      if (i > 0)
      {
        System.out.print(" | ");
      }
      System.out.print(sum.get(i));
    }
  }
}