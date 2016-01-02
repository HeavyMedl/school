public class BankingAccount
{
  private double balance;
  
  public BankingAccount()
  {
    balance = 0;
  }
  
  public BankingAccount(double initialValue)
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
  
  // Let's print information
  public static void main(String[] args)
  {
    BankingAccount kurtschecking = new BankingAccount(500);
    System.out.print("You have ");
    System.out.print(kurtschecking.getBalance());
    System.out.print(" dollars in your checking.");
  }

}