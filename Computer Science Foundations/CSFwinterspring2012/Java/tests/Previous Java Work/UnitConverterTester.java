public class UnitConverterTester
{
  public static void main(String[] args)
  {
    UnitConverter inToft = new UnitConverter("in","ft",12);
    inToft.startConversion();
    System.out.println(inToft.endConversion());
  }
}