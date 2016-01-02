public class FactorGenerator
{
  private int factor;
  private int number;
  
  public FactorGenerator(int aNum)
  {
    number = aNum;
    factor = 2;
  }
  
  public boolean hasMoreFactors()
  {
    while (factor <= number) {
      if (number % factor == 0)
        return true;
      else
        factor++; }
    return false;
  }
  
  public int nextFactor() {
    if (hasMoreFactors()) {
      number /= factor;
      return factor;
    }
    else
      throw new RuntimeException("There are no more factors");
  }
}