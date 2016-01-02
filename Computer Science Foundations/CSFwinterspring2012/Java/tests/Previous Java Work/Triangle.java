public class Triangle
{
  private int width;
  
  public Triangle(int aWidth)
  {
    width = aWidth;
  }
  
  public String toString()
  {
    String row = "";
    for (int i = 1; i <= width; i++)
    {
      for (int j = 1; j <= i; j++)
        row = row + "[]";
      row = row + "\n";
    }
    return row;
  }
}