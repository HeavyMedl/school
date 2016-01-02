public class Triangle extends Shape {
  private int base;
  private int height;
  
  public Triangle(int abase, int aheight) {
    base = abase;
    height = aheight;
  }
  
  public double area() {
    return (.5 * base * height);
  }
  
  public void printShape() {
    System.out.println("I'm a triangle!");
  }
}