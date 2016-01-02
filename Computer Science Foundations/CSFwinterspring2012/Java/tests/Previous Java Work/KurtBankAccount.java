public class KurtBankAccount
{
  private double balance;

// CONSTRUCTORS
// 1st Constructor sets balance to 0
  public KurtBankAccount()
  {
    balance = 0; }

// 2nd Constructor sets the balance to the value supplied as the construction parameter
  public KurtBankAccount(double initialBalance)
  {
    balance = initialBalance; }

// METHODS
  public void deposit(double amount)
  {
    balance = balance + amount; }

  public void withdraw(double amount)
  {
    balance = balance - amount; }

  public double getBalance()
  {
    return balance; }
}