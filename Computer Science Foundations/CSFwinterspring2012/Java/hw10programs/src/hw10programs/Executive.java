package hw10programs;

/**
 *
 * @author kurtmedley
 */
public class Executive extends Manager{
    public Executive(String aName, String aDep, int aSal) {
        super(aName, aDep, aSal);
    }
    
    public static void main(String[] args) {
        Executive kurt = new Executive("Kurt","Board member", 1000000000);
        System.out.println(kurt.toString());
    }
}
