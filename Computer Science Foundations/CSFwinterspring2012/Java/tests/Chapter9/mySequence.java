public class mySequence implements Sequence
{
  private int current = 0;
  private int[] values = {52346,
    345634,
    56456,
    275237,
    7234574,
    34545,
    3673457,
    73457345,
    4573457,
    23464 };
  
  public boolean hasNext() {
    return current < values.length;
  }
  public int next() {
    int value = values[current]++;
    return value;
  }
}
  