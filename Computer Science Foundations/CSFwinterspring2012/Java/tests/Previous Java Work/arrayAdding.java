public class arrayAdding
{
  private double sum;
  private int count;
  
  public arrayAdding(int aSum) {
    sum = aSum;
    count = 0;
    int[] myarray = new int[10];
  }
  
  public void add(double... values) {
    for (int i = 0; i < values.length; i++) 
    {
      double x = values[i];
      sum = sum + x;
      count++; }
  }
  public int fillArray() {
    int[] array = new int[10];
    for (int i = 0; i < array.length; i++) {
      array[i] = i + i;
      System.out.print(array[i]); }
     return array[1];
  }
  
  public double getSum() {
    return sum; }
  
  public static void main(String[] args) {
    
    
    arrayAdding myobject = new arrayAdding(0);
    myobject.add(1,2,3,4,5);
    System.out.println(myobject.getSum());
    int[] array1 = new int[10];
    for (int i = 0; i < array1.length; i++) {
      array1[i] = i + i;
      System.out.println(array1[i]); }

   
  }
}
    
    