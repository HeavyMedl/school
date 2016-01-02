import java.util.Random;

public class Die implements Measurable
{
  private Random generator;
  private int sides;
  private double value;
  
  //Implement interface
  public double getMeasure() {
    return value;
  }
  public Die(int s) 
  {
    sides = s;
    generator = new Random();
    value = 0;
  }
  
  public double cast() {
    value = 1 + generator.nextInt(sides);
    return value;
  }
}