import java.awt.Rectangle;

public class DataSet1Tester
{
  public static void main(String[] args)
  {
    Measurer m = new RectangleMeasurer();
    
    DataSet1 data = new DataSet1(m);
    
    data.add(new Rectangle(5,10,20,30));
    data.add(new Rectangle(10,20,30,40));
    data.add(new Rectangle(20,30,5,15));
    
    System.out.println("Average area: " + data.getAverage());
    
    Rectangle max = (Rectangle) data.getMaximum();
    System.out.println("Maximum area rectangle: " + max);
    
    Measurer p = new PersonMeasurer();
    DataSet1 people = new DataSet1(p);
    
    people.add(new Person("Kurt", 75));
    people.add(new Person("Chuck", 86));
    people.add(new Person("Jon", 78));
    
    System.out.println("Average Height: " + people.getAverage());
    Person tallest = (Person) people.getMaximum();
    System.out.println("Tallest: " + tallest.getHeight());
    System.out.println("Name: " + tallest.getName());



    
  }
}