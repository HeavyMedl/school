import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/* This program calculates the number of lines, words, and characters
 * in a given file.
 */

public class Files {
    
    
    public static void main(String[] args) throws FileNotFoundException {
        int words = 0;
        int lines = 0;
        int chars = 0;
        
        /* Prompt user for file name to be analyed */
        
        Scanner inputFile = new Scanner(System.in);
        System.out.print("Input: ");
        String filename = inputFile.next();
        Scanner file = new Scanner(new File(filename));
        
        /* Calculate lines, words, and chars of file */
        
        while (file.hasNextLine()) {
            String line = file.nextLine();
            lines++;
            Scanner lineln = new Scanner(line);
            while(lineln.hasNext()) {
                String word = lineln.next();
                words++; 
                chars += word.length(); } }
        
        /* Print results */
        
        System.out.println("Words: "+words+" Lines: "+lines+
                " Chars: "+chars);
        System.out.println("Location:" + "\n" + 
                new File(filename).getAbsoluteFile());
    }
}