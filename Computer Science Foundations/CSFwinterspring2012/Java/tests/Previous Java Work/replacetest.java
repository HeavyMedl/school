import java.awt.Rectangle;

public class replacetest {
  public static void main(String[] args)
  {
    String greeting = "Hello World!";
    String river = "Mississippi";
    
    System.out.println(greeting);
    
    river = river.replace("issipp", "our");
    
    System.out.println(river);
    
    System.out.println(greeting);
    
    int n = greeting.length();
    System.out.println(n);
    
    String bigGreeting = greeting.toUpperCase();
    System.out.println(bigGreeting);
    
    System.out.println(new Rectangle(5,10,20,30));
    
    System.out.println(new Rectangle().getWidth());
    
    Rectangle kurtsBox = new Rectangle (10,20,30,40);
    System.out.println(kurtsBox);
    System.out.println(kurtsBox.getHeight());
    
  }
}