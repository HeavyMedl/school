package hw10programs;

public class AccountTest2
{
   public static void main(String[] args)
   {
      SavingsAccount kurt = new SavingsAccount(500, 5);
      CheckingAccount harrysChecking = new CheckingAccount(0);
      
      test(kurt);
      System.out.println(kurt.getBalance());      
      
      test(harrysChecking);
      System.out.println(harrysChecking.getBalance());      
   }

   public static void test(BankAccount account)
   {
      account.deposit(1000);
      account.withdraw(500);
      account.deposit(200);
      account.deposit(300);
      account.withdraw(400);

      account.endOfMonth();
   }
}
