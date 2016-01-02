public class LastDigitDistribution
{
  private int[] counters;
  public LastDigitDistribution()
  {
    counters = new int[10];
  }
  
  public void process(Sequence seq)
  {
    while (seq.hasNext())
    {
      int value = seq.next();
      int lastDigit = value % 10;
      counters[lastDigit]++;
    }
  }
  public void display()
  {
    for (int i = 0; i < counters.length; i++) {
      System.out.println(i + ":" + counters[i]);
    }
  }
}