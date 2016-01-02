public class CashRegister
{
  public static final double QUARTER_VALUE = 0.25;
  public static final double DIME_VALUE = 0.1;
  public static final double NICKEL_VALUE = 0.05;
  public static final double PENNY_VALUE = 0.01;
  public static final double DOLLAR_VALUE = 1.0;
  
  private double purchase;
  private double payment;
  private int numberofitemsSold;
  
  public CashRegister()
  {
    purchase = 0;
    payment = 0;
    numberofitemsSold = 0;
  }
  
  public void enterDollars(int amount)
  {
    payment = payment + amount;
  }
  
  public void enterQuarters(int amount)
  {
    payment = payment + amount * QUARTER_VALUE;
  }
  
  public void enterDimes(int amount)
  {
    payment = payment + amount * DIME_VALUE;
  }
  
  public void enterNickels(int amount)
  {
    payment = payment + amount * NICKEL_VALUE;
  }
  
  public void enterPennies(int amount)
  {
    payment = payment + amount * PENNY_VALUE;
  }
  
  public void recordPurchase(double amount)
  {
    purchase = purchase + amount;
    numberofitemsSold++;
  }
  
  public void enterPayment(int dollars, int quarters, int dimes, int nickels, int pennies)
  {
    payment = dollars * DOLLAR_VALUE + quarters * QUARTER_VALUE + dimes * DIME_VALUE + nickels
                     * NICKEL_VALUE + pennies * PENNY_VALUE;
  }
  
  public double giveChange()
  {
    double change = payment - purchase;
    purchase = 0;
    payment = 0;
    numberofitemsSold = 0;
    return change;
  }
  
  public int getItems()
  {
    return numberofitemsSold;
  }
}

