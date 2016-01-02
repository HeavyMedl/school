public class BankAccount2
{
  private double balance;
  
  public BankAccount2()
  {
    balance = 0;
  }
  
  public BankAccount2(double initialValue)
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
    BankAccount2 kurtschecking = new BankAccount2(1000);
    System.out.print("Kurt's checking balance:  ");
    System.out.println(kurtschecking.getBalance());
  }
}