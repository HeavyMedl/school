public class Coin implements Measurable {
  private double value;
  private String name;
  
  public double getMeasure() {
    return value;
  }
  Coin(double aValue, String aName) {
    value = aValue;
    name = aName;
  }
}