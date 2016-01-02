import java.awt.Rectangle;
import java.awt.geom.*;

public class Geometry 
{
  public static double area(Rectangle rect)
  {
    return rect.getWidth() * rect.getHeight();
  }
  
  /** Method for computing angle of a line formed by two sets of points (x1,x2), (y1,y2) and x-axis
    * @param p  first set of points (x1,x2)
    * @param q  second set of points (y1,y2)
      (Precondition: p and q must be doubles)
    */
  
  public static double angle(Point2D.Double p, Point2D.Double q)
  {
    return Math.atan2(q.getY() - p.getY(), q.getX() - p.getX()) * 180/Math.PI;
  }
  
  /** Method for computing the slope of a line formed by two sets of points (x1,x2), (y1,y2)
    * @param p  first set of points (x1,x2)
    * @param q  second set of points (y1,y2)
    * (Precondition: p and q must be doubles)
    */
  
  public static double slope(Point2D.Double p, Point2D.Double q)
  {
    return (p.getY() - q.getY()) / (p.getX() - q.getX());
  }
}
  
    