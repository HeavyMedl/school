public class DataSetTester
{
  public static void main(String[] args)
  {
    DataSet sequence = new DataSet(1,2,3,4,5);
    System.out.println("Count: " + sequence.getCount());
    System.out.println("Added Value: " + sequence.addValue(5) + "Count: " + sequence.getCount());
    System.out.println("Added Value: " + sequence.addValue(5) + "Count: " + sequence.getCount());
    System.out.println("Added Value: " + sequence.addValue(5) + "Count: " + sequence.getCount());
    System.out.println("Added Value: " + sequence.addValue(5) + "Count: " + sequence.getCount());
    System.out.println(sequence.getSum());
  }
}
