import java.awt.Rectangle;

public class FourRectanglePrinter
{
  public static void main(String[] args)
  {
    Rectangle box = new Rectangle(5,10,20,30);
    System.out.println(box);
    
    box.translate(20,0);
    System.out.println(box);
    
    box.translate(0,30);
    System.out.println(box);
    
    box.translate(-20,0);
    System.out.println(box);
  }
}