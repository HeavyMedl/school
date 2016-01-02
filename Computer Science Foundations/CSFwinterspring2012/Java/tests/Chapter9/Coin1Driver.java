public class Coin1Driver
{
  public static void main(String[] args)
  {
    Coin1 quarter = new Coin1(0.25, "Quarter");
    Coin1 dime = new Coin1(0.10, "Dime");
    Coin1 quarter2 = new Coin1(0.25, "Quarter");
    
    System.out.println("Is quarter object equal to dime object? [0Y/1N]: " 
                         + quarter.compareTo(dime));
    
    System.out.println("Is quarter object equal to quarter2 object? [0Y/1N]: " 
                         + quarter.compareTo(quarter2));
  }
}