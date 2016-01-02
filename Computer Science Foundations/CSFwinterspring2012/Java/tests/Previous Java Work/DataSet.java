public class DataSet
{
  
  private int total;
  private int count;
  private int x1;
  private int x2;
  private int x3;
  private int x4;
  private int x5;
  private int largest;
  private int smallest;
  
  public DataSet()
  {
    total = 0;
    count = 0;
    largest = 0;
    smallest = 0;
    x1 = 0;
    x2 = 0;
    x3 = 0;
    x4 = 0;
    x5 = 0;
  }
  
  public DataSet(int x1, int x2, int x3, int x4, int x5)
  {
    total = x1 + x2 + x3 + x4 + x5;
  }
  
  public int addValue(int x)
  {
    total = (x + x1) + (x + x2) + (x + x3) + (x + x4) + (x + x5);
    count++;
    x1 = x + x1;
    x2 = x + x2;
    x3 = x + x3;
    x4 = x + x4;
    x5 = x + x5;
    return total;
  }
  
  public int getSum()
  {
    count = 0;
    return total;
  }
  
  public int getAverage()
  {
    total = total / 2;
    count++;
    return total;
  }
  
  public int getCount()
  {
    return count;
  }
  

  public static void main(String[] args)
  {
    DataSet sequence = new DataSet(1,2,3,4,5);
    System.out.println("Total: " + sequence.getSum());
    System.out.println("Add Value: " + sequence.addValue(5));
    System.out.println(sequence.getSum());
  }
}
