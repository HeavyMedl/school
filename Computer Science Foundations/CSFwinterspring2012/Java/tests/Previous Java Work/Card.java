public class Card
{
  private static final String A = "Ace";
  private static final String K = "Kings";
  private static final String J = "Jacks";
  private static final String Q = "Queen";
  private static final String D = "Diamonds";
  private static final String H = "Hearts";
  private static final String S = "Spades";
  private static final String C = "Clubs";
  
  private int cardnumber;
  private String cardtype;
  private String two;
  private String three;
  private String four;
  private String five;
  private String six;
  private String seven;
  private String eight;
  private String nine;
  private String ten;
  private String one;
  
  public Card(int x, String c)
  {
    cardnumber = x;
    cardtype = c;
    one = "Ace";
    two = "Two";
    three = "Three";
    four = "Four";
    five = "Five";
    six = "Six";
    seven = "Seven";
    eight = "Eight";
    nine = "Nine";
    ten = "Ten";
  }
  
  public String getDescription()
  {
    String cd = "";
    if (cardnumber < 2 || cardnumber > 10)
    {
      if (cardnumber == 1)
      {
        cd = one + " of " + cardtype;
      }
      else
      {
        cd = "Unknown.";
      }
    }
    else
    {
      if (cardnumber >= 2 && cardnumber <= 10)
      {
        if (cardnumber == 2)
          cd = two + " of " + cardtype;
        if (cardnumber == 3)
          cd = three + " of " + cardtype;
        if (cardnumber == 4)
          cd = four + " of " + cardtype;
        if (cardnumber == 5)
          cd = five + " of " + cardtype;
        if (cardnumber == 6)
          cd = six + " of " + cardtype;
        if (cardnumber == 7)
          cd = seven + " of " + cardtype;
        if (cardnumber == 8)
          cd = eight + " of " + cardtype;
        if (cardnumber == 9)
          cd = nine + " of " + cardtype;
        if (cardnumber == 10)
          cd = ten + " of " + cardtype;
      }
    }
    return cd;
  }
  
  public static void main(String[] args)
  {
    Card tester = new Card(4, K);
    System.out.println(tester.getDescription());
  }
}