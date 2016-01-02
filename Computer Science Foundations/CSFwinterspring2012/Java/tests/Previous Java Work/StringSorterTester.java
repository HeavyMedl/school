public class StringSorterTester
{
  public static void main(String[] args)
  {
    StringSorter threestrings = new StringSorter("Aaron", "Theodore", "Patricia");
    threestrings.makeSort();
    System.out.println("First Name: " + threestrings.getFirst());
    System.out.println("Second Name: " + threestrings.getSecond());
    System.out.println("Third Name: " + threestrings.getThird());
  }
}