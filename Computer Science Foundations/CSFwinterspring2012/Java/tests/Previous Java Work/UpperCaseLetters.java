public class UpperCaseLetters
{
  public static void main(String[] args)
  {
    int upperCaseLetters = 0;
    String kurt = "Hello Kurt ABC!";
    
    for (int i = 0; i < kurt.length(); i++)
    {
      char ch = kurt.charAt(i);
      if (Character.isUpperCase(ch))
      {
        upperCaseLetters++;
      }
    }
    System.out.println(upperCaseLetters);
  }
}