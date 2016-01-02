public class Person
{
  private int height;
  private String name;
  
  public Person() {}
  
  public Person(String aName, int aHeight) {
    name = aName;
    height = aHeight;
  }
  public String getName() {
    return name;
  }
  public int getHeight() {
    return height;
  }
  
  //public double measure(Object anObject) {
    //Person aPerson = (Person) anObject;
    //double height = aPerson.getHeight();
    //return height;
  
}