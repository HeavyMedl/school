public class Coin1 implements Comparable
{
  private double value;
  private String name;
  
  public int compareTo(Object obj) {
    if (this.getName().equalsIgnoreCase(((Coin1)obj).getName())) {
      return 0; }
    else if (this.getName().length() > ((Coin1)obj).getName().length()) {
      return 1; }
    else {
      return -1; }
  }
  
  public Coin1(double aValue, String aName) {
    value = aValue;
    name = aName;
  }
  
  public String getName() {
    return name;
  }
  public double getValue() {
    return value;
  }
}
        