import java.util.Scanner;

/* A program that takes user input, parses it to a double, and calculates the
 * sum of all 5 given inputs.  If the input is a character, an exception
 * is thrown and the method "calculate" is reiterated.
 */

public class floatSum {
    int tries = 0;
    int sumcount = 0;
    
    double sum = 0;
    String input;
    double parse;
    Scanner cmdline = new Scanner(System.in);

    
    public floatSum() { }
    
    public void calculate() {
        try {
            for (int i=0; i < 5; i++) {
                if (tries == 3) {
                    System.out.println("Total: "+sum);
                    System.exit(0); } 
                else
                    if (sumcount < 5) {
                        System.out.println("Enter floating point number: ");
                        input = cmdline.next();
                        parse = Double.parseDouble(input);
                        sum += parse;
                        sumcount++; }           
            }
            System.out.println("Total: "+sum);
        }
         catch (NumberFormatException exception) {
             System.out.println("Input was not a number.");
             tries++;
             calculate();
                     
            }
        }
    
    public static void main(String[] args) {
        floatSum test = new floatSum();
        test.calculate();
    }
}
            
          