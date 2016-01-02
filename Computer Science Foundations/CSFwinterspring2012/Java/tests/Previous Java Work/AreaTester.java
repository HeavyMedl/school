import java.awt.Rectangle;

public class AreaTester
{
  public static void main(String[] args)
  {
    Rectangle box = new Rectangle(5,10,20,30);
    System.out.println(box);
    
    double area = box.getWidth() * box.getHeight();
    
    System.out.print("Area:  ");
    System.out.println(area);
    System.out.println("Expected: 600");
  }
}