package tests.money;
public class CashRegister2tester
{
  public static void main(String [] args) {
   
    final double QUARTER_VALUE = 0.25;
    final int DOLLAR_VALUE = 1;
    final double NICKEL_VALUE = 0.05;
    final double DIME_VALUE = 0.10;
    final double PENNY_VALUE = 0.01;
    
    
    CashRegister2 register = new CashRegister2();
    register.recordPurchase(50.75);
    
    System.out.println("Items Sold: " + register.getItems());
    
    register.enterPayment(60, new Bill(DOLLAR_VALUE, "dollar"), 5, new Coin(QUARTER_VALUE, "quarter"));
    
    System.out.println("Change: " + register.giveChange(new Coin(DOLLAR_VALUE, "dollar")));

  }
}