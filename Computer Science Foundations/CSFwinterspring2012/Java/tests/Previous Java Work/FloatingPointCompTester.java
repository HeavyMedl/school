public class FloatingPointCompTester
{
  public static void main(String[] args)
  {
    FloatingPointComp twofloats = new FloatingPointComp(2.0, 2.99998);
    System.out.println(twofloats.getCompare());
    System.out.println(twofloats.differLess());
  }
}
   