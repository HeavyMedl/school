public class DigitExtractor
{
  private int original;
  private int newvalue;
  private int nextdigit;
  
  public DigitExtractor (int anInteger)
  {
    original = anInteger;
  }
  
  public int nextDigit()
  {
    newvalue = original / 10;
    nextdigit = newvalue % 10;
    original = newvalue;
    return nextdigit;
  }
  
  public static void main(String[] args)
  {
    DigitExtractor myExtractor = new DigitExtractor(51560);
    System.out.println(myExtractor.nextDigit());
    System.out.println(myExtractor.nextDigit());
    System.out.println(myExtractor.nextDigit());
    System.out.println(myExtractor.nextDigit()); 
  }
}