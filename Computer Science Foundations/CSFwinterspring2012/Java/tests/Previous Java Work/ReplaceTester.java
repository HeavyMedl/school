public class ReplaceTester
{
  public static void main(String[] args)
  {
    String river = "Mississipi";
    System.out.println(river);
    
    river = river.replace("i", "!");
    river = river.replace("s", "$");
    System.out.println(river);
    
  }
}