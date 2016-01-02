public class arraySum
{
  public static void main(String[] args) 
  {
    // Create a new array
    double[] array = new double[10];
    
    // Fill the array with index values
    for (int i = 0; i < array.length; i++) {
      array[i] = i * i; }
    
    // Sum up the array elements
    double sum = 0;
    for (int i = 0; i < array.length; i++) {
      sum = sum + array[i];
    }
    // Print the sum of array elements
    System.out.println("The sum of array elements: " + sum);
    
    // Print the inidividual elements of the array
    for (int i = 0; i < array.length; i++) {
      if (i > 0) {
        System.out.print(" | "); }
      System.out.print(array[i]); }
    System.out.println();
    
    // Calculate the average
    double average = sum / array.length;
    // Print the average
    System.out.println("Average: " + average);
  }
}
