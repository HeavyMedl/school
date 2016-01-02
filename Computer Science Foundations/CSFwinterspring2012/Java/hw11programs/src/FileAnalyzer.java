import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/* This program reports the number of lines, words, and characters in
 * a file
 */

public class FileAnalyzer {
    
    public static void main(String[] args) throws FileNotFoundException {
        
        /* First block: prompt user for file name */
        
        Scanner cmdline = new Scanner(System.in);
        System.out.print("Input file to be analyzed: ");
        String filename = cmdline.next();
        
        /* Analyze the given file */
        
        Scanner a = new Scanner(new File(filename));
        int lineNumber = 0;
        while (a.hasNextLine()) {
            String line = a.nextLine();
            lineNumber++;
        }
        System.out.println("Line Number: "+lineNumber);
        
        Scanner b = new Scanner(new File(filename));
        int wordNumber = 0;
        while (b.hasNext()) {
            String word = b.next();
            wordNumber++;
        }
        System.out.println("Word Number: "+wordNumber);
        
        Scanner c = new Scanner(new File(filename));
        int charNumber = 0;
        c.useDelimiter("");
        while (c.hasNext()) {
            char ch = c.next().charAt(0);
            charNumber++;
            }
        System.out.println("Character Number: "+charNumber);
        
        a.close();
        b.close();
        c.close();
    }
    
}