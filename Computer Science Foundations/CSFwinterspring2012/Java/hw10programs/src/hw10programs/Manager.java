package hw10programs;
/**
 *
 * @author kurtmedley
 */
public class Manager extends Employee {
    
    public Manager(String aName, String aDep, int aSal) {
        super(aName, aDep, aSal);
    
    }
    
    public static void main(String[] args) {
        Manager kurt = new Manager("Kurt","The highest",1000000);
        System.out.println(kurt.toString()); 
    }
}
