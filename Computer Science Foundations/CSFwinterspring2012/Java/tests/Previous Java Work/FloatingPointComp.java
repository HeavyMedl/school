public class FloatingPointComp
{
  final double EPSILON = 1E-14;
  private double firstfloat;
  private double secondfloat;
  
  public FloatingPointComp(double aNum, double aaNum)
  {
    firstfloat = aNum;
    secondfloat = aaNum;
  }
  
  public String getCompare()
  {
    String same = "They are the same when rounded to two decimal places.";
    String different = "They are different when rounded to two decimal places.";
    if (Math.abs(firstfloat - secondfloat) < 0.01) {
      return same; }
    else
      return different; 
  }
  
  public String differLess()
  {
    String differless = "They differ by less than 0.01";
    String notless = "They do not differ by less than 0.01";
    if (Math.abs(firstfloat - secondfloat) < 0.01)
      return differless;
    else
      return notless;
  }
}

