
public class PersonMeasurer extends Person implements Measurer
{
  public double measure(Object anObject)
  {
    Person aPerson = (Person) anObject;
    double height = aPerson.getHeight();
    return height;
  }
}
    