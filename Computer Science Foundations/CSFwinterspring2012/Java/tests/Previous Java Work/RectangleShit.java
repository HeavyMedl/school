import java.awt.Rectangle;
  
public class RectangleShit
{
  public static void main(String[] args)
  {
    Rectangle kurtsfuckingrectangle = new Rectangle(5,10,20,30);
    
    System.out.println(kurtsfuckingrectangle);
    
    kurtsfuckingrectangle.getWidth();
    
    System.out.print("Width:  ");
    System.out.println(kurtsfuckingrectangle.getWidth());
    
    double perimeter = 2 * (kurtsfuckingrectangle.getWidth() * kurtsfuckingrectangle.getHeight());
    System.out.print("Perimeter:  ");
    System.out.println(perimeter);
    
    double area = kurtsfuckingrectangle.getWidth() * kurtsfuckingrectangle.getHeight();
    System.out.print("Area:  ");
    System.out.println(area);
    
  }
}