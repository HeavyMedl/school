public class SavingsAccount
{
  private double balance;
  private double interest;
  
  public SavingsAccount()
  {
    balance = 0;
    interest = 10;
  }
  
  public SavingsAccount(double initialvalue, double initialinterest)
  {
    balance = initialvalue;
    interest = initialinterest;
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
  public double addInterest()
  {
    double addedinterest = balance * (interest / 100);
    balance = balance + addedinterest;
    return balance;
  }
  
  public static void main(String [] args)
  {
    SavingsAccount savingsaccounttester = new SavingsAccount(1000, 10);
    System.out.println(savingsaccounttester.getBalance());
    System.out.println(savingsaccounttester.addInterest());
    System.out.println(savingsaccounttester.addInterest());
  }
  
  
  
}