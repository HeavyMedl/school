import java.util.Scanner;

public class FloatingSum {
    public static void main(String[] args) {
        int tries = 0;
        String inputs;
        double dinputs;
        double sum = 0.0;
        
        /* Prompt user for a set of floating point numbers */
        Scanner cmdline = new Scanner(System.in);
        try {
            for (int i=0; i < 5; i++) {
                if (tries == 3) {
                    System.out.println(sum);
                    System.exit(0); }
                else {
                    System.out.println("Enter floating point number: ");
                    inputs = cmdline.next();
                    dinputs = Double.parseDouble(inputs);
                    sum += dinputs; }  
            }
            System.out.println("Total: "+sum);
        }
        
        catch (NumberFormatException exception)
        {
            System.out.println("Input Mismatch. Try again.");
            tries++;           
        }
    }
}
