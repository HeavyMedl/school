package hw10programs;

/**
 *
 * @author kurtmedley
 */
public class CheckingAccount extends BankAccount {
    private int transactionCount;
    
    private static final int FREE_TRANSACTIONS = 3;
    private static final double TRANSACTION_FEE = 2.0;
    
    public CheckingAccount(double initBalance) {
        super(initBalance);
        transactionCount=0;
    }
    
    @Override
    public void deposit(double amount) {
        transactionCount++;
        super.deposit(amount);
    }
    
    @Override
    public void withdraw(double amount) {
        transactionCount++;
        super.withdraw(amount);
        
    }
    
    @Override
    public void endOfMonth() {
        if (transactionCount > FREE_TRANSACTIONS)
        { double fees = TRANSACTION_FEE *
                (transactionCount-FREE_TRANSACTIONS);
        super.withdraw(fees); }
        transactionCount = 0;
    }

    @Override
    void deductFees() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
