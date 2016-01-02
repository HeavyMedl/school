/**
 * A bank account has a balance that can be changed by deposits and withdrawls.
 * (Precondition: initialValue >= 0)
 */

public class BankAccount
{
  private double balance;
  
  public BankAccount()
  {
    balance = 0;
  }
  public BankAccount(double initialValue)
  {
    assert initialValue >= 0;
    balance = initialValue;
  }
  
  /**
   * Deposits money into a bank account.
   * @param amount  the amount to be deposited.
   * (Precondition: amount >= 0)
   */
  
  public void deposit(double amount)
  {
    assert amount >= 0;
    balance = balance + amount;
  }
  
  /**
   * Withdraws money from a bank account.
   * @param amount  the amount to be withdrawn.
   * (Precondition: amount <= getBalance())
   */
  
  public void withdraw(double amount)
  {
    assert amount <= getBalance();
    balance = balance - amount;
  }
  public double getBalance()
  {
    return balance;
  }
  public void addInterest(double rate)
  {
    rate = balance * (rate / 100);
    balance = balance + rate;
  }
  
  public static void main(String[] args)
  {
    BankAccount KurtsChecking = new BankAccount(100);
    KurtsChecking.deposit(100);
    KurtsChecking.addInterest(5);
    System.out.println(KurtsChecking.getBalance());

  }
}
    