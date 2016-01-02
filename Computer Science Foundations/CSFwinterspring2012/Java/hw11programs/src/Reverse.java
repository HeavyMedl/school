import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class Reverse {
    public static void main(String[] args) throws FileNotFoundException {
        /* Prompt for input file */
        Scanner cmdline = new Scanner(System.in);
        System.out.println("Enter name of file to be reversed: ");
        String inFileName = cmdline.next();
        Scanner in = new Scanner(new File(inFileName)); 
        
        /* Prompt for output file name */
        System.out.println("Enter new name of file: ");
        String outFileName = cmdline.next();
        PrintWriter outfile = new PrintWriter(outFileName);
        
        while (in.hasNextLine()) {
            String originalline = in.nextLine();
            StringBuffer buffer = new StringBuffer(originalline);
            buffer.reverse();
            String reversedline = buffer.toString();
            outfile.println(reversedline);
        }
        outfile.close();
    }
    
}