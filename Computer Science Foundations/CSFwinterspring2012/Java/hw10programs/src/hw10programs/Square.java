package hw10programs;
import java.awt.*;
/**
 *
 * @author kurtmedley
 */
public class Square extends Rectangle {
    private int x;
    private int y;
    private int side;
    
    public Square(int theside, int varX, int varY) {
        x = varX;
        y = varY;
        side = theside;
        setLocation(x,y);
        setSize(side,side);
    }
    
    public int getArea() { 
        int area = side * side;
        return area;
    }
    
    
    
             
            
}
