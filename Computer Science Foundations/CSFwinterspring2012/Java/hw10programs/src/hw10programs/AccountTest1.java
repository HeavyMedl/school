package hw10programs; 

public class AccountTest1 {
    
    public static void test(BankAccount account) {
        for (int i = 1; i <= 5; i++)
        {
            if (i % 2 == 1)
                account.deposit(i * 1000);
            else
                account.withdraw(i * 500);
        }
        account.endOfMonth();
    }
    
    public static void main(String[] args)
   {
      SavingsAccount kurtsave = new SavingsAccount(5, 5);
      CheckingAccount chuckcheck = new CheckingAccount(0);
      
      test(kurtsave);
      System.out.println(kurtsave.getBalance());      
      
      test(chuckcheck);
      System.out.println(chuckcheck.getBalance());      
   }
}