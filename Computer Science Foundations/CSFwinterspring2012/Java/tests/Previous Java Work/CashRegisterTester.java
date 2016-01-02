public class CashRegisterTester
{
  public static void main(String[] args)
  {
    CashRegister register = new CashRegister();
    register.recordPurchase(20.37);
    System.out.println("Number of items sold:  " + register.getItems());
    register.enterDollars(20);
    register.enterQuarters(2);
    System.out.println("Change:  " + register.giveChange());
    System.out.println("Expected: 0.13");
    System.out.println("Number of items sold:  " + register.getItems());
    register.recordPurchase(1.50);
    System.out.println("Number of items sold:  " + register.getItems());
    
  }
}