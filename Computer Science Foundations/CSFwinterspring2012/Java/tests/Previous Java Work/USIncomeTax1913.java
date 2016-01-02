public class USIncomeTax1913
{
  public static final double ONE_PERCENT = 0.01;
  public static final double TWO_PERCENT = 0.02;
  public static final double THREE_PERCENT = 0.03;
  public static final double FOUR_PERCENT = 0.04;
  public static final double FIVE_PERCENT = 0.05;
  public static final double SIX_PERCENT = 0.06;
  
  private double income; 
  
  public USIncomeTax1913(double enteredincome)
  {
    income = enteredincome;
  }
  
  public double calculateTax()
  {
    double tax = 0;
    if (income <= 50000)
      tax = income * ONE_PERCENT;
    else if (income <= 75000)
      tax = income * TWO_PERCENT;
    else if (income <= 100000)
      tax = income * THREE_PERCENT;
    else if (income <= 250000)
      tax = income * FOUR_PERCENT;
    else if (income <= 500000)
      tax = income * FIVE_PERCENT;
    else 
      tax = income * SIX_PERCENT;
    return tax;
  }
}