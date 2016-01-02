import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class moreFiles {
    
    public static void main(String[] args) {
        int words = 0;
        int lines = 0;
        int chars = 0;
        
        for (int i = 0; i <= 4; i++) {
            
            try 
            {                    
                /* prompt the user */
                Scanner cmdline = new Scanner(System.in);
                System.out.print("Input File: ");
                String inputFile = cmdline.next();
                Scanner file = new Scanner(new File(inputFile));
                
                /* process the given file */
                while (file.hasNextLine()) {
                    String line = file.nextLine();
                    lines++;
                    Scanner lineln = new Scanner(line);
                        while (lineln.hasNext()) {
                        String word = lineln.next();
                        words++; 
                        chars += word.length(); } }
            } 
        
            catch (FileNotFoundException ex) 
            {
                /* If an exception is thrown, System gives combined number of
                 * lines, words, chars with the last valid file names
                 */
                System.out.println("File Not Found! Totals:");
                System.out.println("Lines: " +lines+ "\n" +
                                   "Words: " +words+ "\n" +
                                   "Chars: " +chars);
                System.exit(0); 
            }
        }
        System.out.println("Lines: " +lines+ "\n" +
                           "Words: " +words+ "\n" +
                           "Chars: " +chars);            
    }
}
  