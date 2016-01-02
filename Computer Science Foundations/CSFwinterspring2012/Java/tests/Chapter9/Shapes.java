class Shapes {
public static void main(String[] args) {
  final int MAXSHAPES = 4;
  Shape[] shapes = new Shape[MAXSHAPES];

  shapes[0] = new Rectangle(3,4);
  shapes[1] = new Circle(5);
  shapes[2] = new Square(5);
  shapes[3] = new Triangle(5,4);
  
  for (int i = 0; i<MAXSHAPES; i++) {
    shapes[i].printShape();
    }
  }
}
