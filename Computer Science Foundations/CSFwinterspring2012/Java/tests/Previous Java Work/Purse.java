import java.util.ArrayList;

// A purse holds a collection of coins.

public class Purse
{
  private ArrayList<String> coins;
  
  public Purse()  // Constructs an empty purse (ArrayList)
  {
    coins = new ArrayList<String>();
  }
  
  public void addCoin(String coinName) // Add a coin type (Quarter, Dime, etc) to the purse (ArrayList called coins)
  {
    coins.add(coinName);
  }
  
  public String toString()  // Returns a string describing the object
  {
    if (coins.size() == 0)  // if the ArrayList "coins" is empty, return Purse[]
      return "Purse[]";
    
    String output = "Purse[";  
    
    for (String coinname : coins)  // Otherwise for each coinname (quarter, dime, etc.) within coins
                                              // return "Purse[ coinname + "," + coinname + "," + etc. ]
    {
      output = output + coinname + ",";
    }
    
    output = output.substring(0, output.length() - 1);
    return output + "]";
  }
  
  public void reverse()
  {
    int i = 0;
    int j = coins.size() - 1;
    while (i < j)
    {
      String temp = coins.get(i);  // set "coins" placeholder to i, "i" will increment from 0 to size of ArrayList
      coins.set(i, coins.get(j));     // set i (position 0+) with element from j (last element in "coins")
      coins.set(j, temp);             // set j (last element in "coins") with element in position "temp" (i)
      i++;                                 // increment I and decrement j until i < j ; done.
      j--;
    }
  }
  public void transfer(Purse other)
  {
    while (other.coins.size() > 0)            // while ArrayLists other and coins' size > 0
      coins.add(other.coins.remove(0));   // ArrayList coins adds contents from index 0 to other, while 
  }                                                     // successively removing elements from coins until its size = 0
                                                       
  public static void main(String[] args)
  {
    Purse kurtspurse = new Purse();
    kurtspurse.addCoin("Quarter");
    kurtspurse.addCoin("Dime");
    
    Purse chuckspurse = new Purse();
    chuckspurse.addCoin("Dollar");
    chuckspurse.addCoin("Quarter");
    chuckspurse.addCoin("Dime");
    
    kurtspurse.transfer(chuckspurse);
    System.out.println(kurtspurse);
    System.out.println(chuckspurse);
    
  }
}