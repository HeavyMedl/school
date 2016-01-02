public class PowerGeneratorRunner
{
  public static void main(String [] args)
  {
    PowerGenerator tens = new PowerGenerator(0);
    for (int i = 0; i < 12; i++){
      System.out.println(tens.nextPower()); }
  }
}