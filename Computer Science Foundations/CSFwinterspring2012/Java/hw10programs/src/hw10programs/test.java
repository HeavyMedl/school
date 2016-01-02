/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hw10programs;
import java.util.Scanner;
/**
 *
 * @author kurtmedley
 */
public class test {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        
        System.out.println("Center X: ");
        int centerx = in.nextInt();
        System.out.println("Center Y: ");
        int centery = in.nextInt();
        System.out.println("Side Length: ");
        int sidelength = in.nextInt();
        
        Square square = new Square(sidelength, centerx, centery);
        System.out.println(square.toString());
        System.out.println("Area: " + square.getArea());
    }
}
