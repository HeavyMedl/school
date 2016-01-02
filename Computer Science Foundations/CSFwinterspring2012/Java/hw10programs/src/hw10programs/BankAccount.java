package hw10programs;

/**
 *
 * @author kurtmedley
 */
public abstract class BankAccount {
    private double balance;
    
    public BankAccount(double initBalance) {
        balance = initBalance;
    }
    
    abstract void deductFees();
    
    void deposit(double amount) {
        balance += amount;
    }
    
    void withdraw(double amount) {
        balance -= amount;
    }
    
    public double getBalance() {
        return balance;
    }
    
    public abstract void endOfMonth();
    
}
