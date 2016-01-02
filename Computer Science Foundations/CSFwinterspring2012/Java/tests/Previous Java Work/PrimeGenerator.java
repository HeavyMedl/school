public class PrimeGenerator
{
  private int number;
  
  public PrimeGenerator(int aNum)
  {
    number = aNum;
  }
  
  public void nextPrime()
  {
    for (int i = 0; i < number; i++) {
      for (int j = 0; j < i; j++) {
        if (i % j == 0)
          break;
        if (i == j) 
        System.out.println(i);
    }
  }
  }
  public static void main(String[] args)
  {
    PrimeGenerator isprime = new PrimeGenerator(20);
    isprime.nextPrime();
  }
}
      