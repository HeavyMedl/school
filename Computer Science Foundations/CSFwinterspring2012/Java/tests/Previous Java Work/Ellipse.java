import java.awt.geom.Ellipse2D;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JComponent;

public class EllipseComponent extends JComponent
{
  public void paintComponent(Graphics g)
  {
    Graphics2D g2 = (Graphics2D) g;
    
    Ellipse2D.Double ellipse = new Ellipse2D.Double(5,10,20,30);
    g2.draw(ellipse);
  }
}