public class Circle extends Shape {
  private double radius;

  public Circle(double r) {
    radius = r;
    }

  public double area() {
    return (3.14 * radius * radius);
    }

  // We should use toString method here so the caller can
  // do the the actual printing.
  public void printShape() {
    System.out.println("I'm a circle!");
  }
}
