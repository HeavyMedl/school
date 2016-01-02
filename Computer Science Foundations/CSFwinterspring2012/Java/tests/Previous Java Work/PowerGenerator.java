public class PowerGenerator
{
  private double factor;
  
  public PowerGenerator(double aFactor)
  {
    factor = aFactor;
  }
  public double nextPower()
  {
    double calculate;
    calculate = Math.pow(10, factor);
    factor++;
    return calculate;
  }
}
