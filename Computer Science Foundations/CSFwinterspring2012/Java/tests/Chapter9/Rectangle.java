public class Rectangle extends Shape {
  private double height, width;

  public Rectangle(double h, double w) {
    this.height = h;   // "this" isn't needed here, but I put it
    this.width = w;    // to emphasise that height and width
    }                  // have implicit object reference "this"

  public double area() {
    return (height*width);
    }

  // We should use toString method here so the caller can
  // do the the actual printing.
  public void printShape() {
    System.out.println("I'm a rectangle!");
  }
}
