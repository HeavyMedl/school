package hw10programs;

/**
 *
 * @author kurtmedley
 */
public class SavingsAccount extends BankAccount {
    
    private double interestRate;
    private double minimum;
    
    public SavingsAccount(double initBalance, double rate) {
        super(initBalance);
        interestRate = rate;
        minimum = initBalance;
    }
    
    
    void addInterest() {
        double interest = interestRate / 100;
        if (minimum < getBalance()) {
            deposit(getBalance() + (minimum * interest)); }
        else {
            deposit(this.getBalance() * interest);
        }
    } 
    
    void withraw(double amount) {
        if (amount > getBalance()) {
            getBalance(); }
        else {
            withdraw(amount); }
            
    }
     
    double getMinimum() { 
        return minimum;
    }
    
    @Override
    public void endOfMonth() {
        double interest = getBalance() * interestRate / 100;
        deposit(interest);
    }
        
       

    @Override
    void deductFees() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
