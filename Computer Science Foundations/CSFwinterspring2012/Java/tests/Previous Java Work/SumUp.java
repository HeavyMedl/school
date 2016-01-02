public class SumUp
{
  private int sum;
  private String random;
  
  public SumUp()
  {
    sum = 0;
    random = "Hello gordon and kim how are we doing today?";
  }
  
  public void getString()
  {
    for (int i = 0; i < random.length(); i++) {
      System.out.print(random.charAt(i));
      sum = sum + i;
      }
  }
  public int getSum()
  {
    return sum;
  }
  
  public static void main(String[]args)
  {
    SumUp test = new SumUp();
    test.getString();
    System.out.println(test.getSum());
  }
}



    