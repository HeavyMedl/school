public class Square extends Shape {
  private double side;

  public Square(double s) {
    side = s;
    }

  public double area() {
    return (side * side);
    }

  // We should use toString method here so the caller can
  // do the the actual printing.
  public void printShape() {
    System.out.println("I'm a square!");
  }
}
