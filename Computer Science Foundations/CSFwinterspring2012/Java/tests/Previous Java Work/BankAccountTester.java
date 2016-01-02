public class BankAccountTester
{
  private double balance;
  
  public BankAccountTester()
  {
    balance = 0;
  }
  
  public BankAccountTester(double initialValue)
  {
    balance = initialValue;
  }
  
  public void deposit(double amount)
  {
    balance = balance + amount;
  }
  
  public void withdraw(double amount)
  {
    balance = balance - amount;
  }
  
  public double getBalance()
  {
    return balance;
  }
  
  public static void main(String[] args)
  {
    BankAccountTester checkingaccount = new BankAccountTester();
    checkingaccount.deposit(1000);
    checkingaccount.withdraw(500);
    checkingaccount.withdraw(400);
    System.out.println("Expected: $100");
    System.out.print("Total Balance: $");
    System.out.print(checkingaccount.getBalance());
  }
}