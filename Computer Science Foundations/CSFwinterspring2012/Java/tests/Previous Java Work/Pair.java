public class Pair
{
  private double aFirst;
  private double aSecond;
  
  public Pair()
  {
    aFirst = 0;
    aSecond = 0;
  }
  
  public Pair(double initFirst, double initSecond)
  {
    aFirst = initFirst;
    aSecond = initSecond;
  }
 
  public double getSum()
  {
    double theSum = aFirst + aSecond;
    return theSum;
  }
  
  public double getDifference()
  {
    double theDifference = aFirst - aSecond;
    return theDifference;
  }
  
  public double getProduct()
  {
    double theProduct = aFirst * aSecond;
    return theProduct;
  }
  
  public double getAverage()
  {
    double theAverage = (aFirst + aSecond) / 2;
    return theAverage;
  }
  
  public double getDistance()
  {
    double theDistance = Math.abs(aFirst - aSecond);
    return theDistance;
  }
  
  public double getLarger()
  {
    double theLarger = Math.max(aFirst, aSecond);
    return theLarger;
  }
  
  public double getSmaller()
  {
    double theSmaller = Math.min(aFirst, aSecond);
    return theSmaller;
  }
  public void newValue(double numberOne, double numberTwo)
  {
    aFirst = numberOne;
    aSecond = numberTwo;
  }
}