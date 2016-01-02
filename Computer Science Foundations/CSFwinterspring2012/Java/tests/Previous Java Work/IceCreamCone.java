public class IceCreamCone
{
  private int height;
  private int radius;
  private int side;
  
  public IceCreamCone()
  {
    height = 20;
    radius = 10;
    side = 20;
  }
  
  public IceCreamCone(int initHeight, int initRadius, int initSide)
  {
    height = initHeight;
    radius = initRadius;
    side = initSide;
  }
  
  public double getSurfaceArea()
  {
    double surfacearea = Math.PI * radius * side;
    return surfacearea;
  }
  
  public double getVolume()
  {
    double volume = (1/3.0) * Math.PI * radius * radius * height;
    return volume;
  }
  
}