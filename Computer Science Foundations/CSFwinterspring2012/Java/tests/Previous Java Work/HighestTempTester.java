public class HighestTempTester
{
  public static void main(String [] args)
  {
    HighestTemperature test = new HighestTemperature();
    test.highesttemp();
    System.out.println("Month with highest temp: " + test.getMaxMonth());
    System.out.println("Temperature value: " + test.getMaxTemp());
  }
}