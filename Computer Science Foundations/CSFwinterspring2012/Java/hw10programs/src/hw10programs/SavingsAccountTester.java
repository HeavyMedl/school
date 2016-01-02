/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hw10programs;

/**
 *
 * @author kurtmedley
 */
public class SavingsAccountTester {
   public static void main(String[] args) {
       SavingsAccount s1 = new SavingsAccount(1000, 5);
       System.out.println("S1 balance = " + s1.getBalance());
       
       SavingsAccount s2 = new SavingsAccount(2000, 5);
       System.out.println("S2 balance = " + s2.getBalance());
       
       s1.deposit(500);
       s1.addInterest();
       System.out.println(s1.getBalance());
       System.out.println(s2.getBalance());
       
       CheckingAccount c1 = new CheckingAccount(100);
       
       
   } 
}
