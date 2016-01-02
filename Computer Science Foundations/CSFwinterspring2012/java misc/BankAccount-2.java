public abstract class BankAccount {
	protected double balance;

	public void deposit(double amt) {
		balance += amt;
	}

	public void withdraw(double amt) {
		balance -= amt;
	}

	public abstract void endOfMonth();
}
	
