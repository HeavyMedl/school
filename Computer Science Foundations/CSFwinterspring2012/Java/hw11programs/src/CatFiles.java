import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class CatFiles {
    
    public static void main(String[] args) throws FileNotFoundException {                
        
        String outFileName = args[args.length-1]; 
        PrintWriter outfile = new PrintWriter(outFileName);
        
        for (int i = 0; i <= args.length-1; i++) {
            String inFileName = args[i];
            Scanner infile = new Scanner(new File(inFileName));
            
                while (infile.hasNextLine()) {
                    String line = infile.nextLine();
                    outfile.println(line);
                }
                infile.close();
        }
        outfile.close();
    }
}