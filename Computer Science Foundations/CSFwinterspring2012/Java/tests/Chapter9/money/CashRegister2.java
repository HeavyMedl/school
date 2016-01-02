package tests.money;
public class CashRegister2
{
  public static final double QUARTER_VALUE = 0.25;
  public static final double DIME_VALUE = 0.1;
  public static final double NICKEL_VALUE = 0.05;
  public static final double PENNY_VALUE = 0.01;
  public static final double DOLLAR_VALUE = 1.0;
  
  private double purchase;
  private double payment;
  private int numberofitemsSold;
  
  public CashRegister2()
  {
    purchase = 0;
    payment = 0;
    numberofitemsSold = 0;
  }
  
  public void recordPurchase(double amount)
  {
    purchase = purchase + amount;
    numberofitemsSold++;
  }
  
  public void enterPayment(int billCount, Bill billType, int coinCount, Coin coinType)
  {
      payment = payment + (billType.getValue() * billCount) + (coinType.getValue() * coinCount);
  }
  
  // from CashRegister
  // payment = dollars * DOLLAR_VALUE + quarters * QUARTER_VALUE + dimes * DIME_VALUE + nickels
  //                    * NICKEL_VALUE + pennies * PENNY_VALUE;
  
  
  public double giveChange(Coin coinType)
  {
    double change = 0;
    if (payment <= purchase)
      return 0;
    else
      change = (payment - purchase) / coinType.getValue();
    
    payment = (payment - change) * coinType.getValue();
    
    if (payment == purchase) {
      payment = 0;
      purchase = 0; 
      numberofitemsSold = 0; }
    return change;
  }
  
  public int getItems()
  {
    return numberofitemsSold;
  }
}