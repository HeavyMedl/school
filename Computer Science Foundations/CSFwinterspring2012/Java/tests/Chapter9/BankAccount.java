public class BankAccount implements Measurable {
  private int balance;
  
  // implement the interface's required methods
  public double getMeasure() {
    return balance;
  }
  // create a constructor that intializes the balance 0+
  public BankAccount(int aBalance) {
    balance = aBalance;
  }
}