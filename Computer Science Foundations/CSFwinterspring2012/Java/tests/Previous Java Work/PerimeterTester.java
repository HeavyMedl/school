import java.awt.Rectangle;

public class PerimeterTester
{
  public static void main(String[] args)
  {
    Rectangle box = new Rectangle(5,10,20,30);
    
    double perimeter = 2 * (box.getWidth() * box.getHeight());
    
    System.out.print("Perimeter:  ");
    System.out.println(perimeter);
    System.out.println("Expected: 1200");
  }
}