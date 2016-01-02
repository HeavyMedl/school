
public class Bug
{
  private int position;
  
  private boolean direction;
  
  public Bug()
  {
    position = 0;
    direction = true;
  }
  
  public Bug(int initialposition)
  {
    position = initialposition;
    direction = true;
  }
  
  public void move(int value)
  {
    if (direction == true) 
      position = position + value; 
    else 
      position = position - value;  
  }
  
  public void turn()
  {
    if (direction == true)  
      direction = false;
    else 
      direction = true;
  }
  
  public int getPosition()
  {
    return position;
  }
  
  public static void main(String[] args)
  {
    Bug beetle = new Bug(10);
    System.out.println(beetle.getPosition());
    beetle.move(10);
    System.out.println(beetle.getPosition());
    beetle.turn();
    beetle.move(20);
    System.out.println(beetle.getPosition());
  }
}
  
  