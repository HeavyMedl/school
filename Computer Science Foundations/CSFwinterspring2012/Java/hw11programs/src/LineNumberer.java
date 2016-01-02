import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class LineNumberer {
    private static boolean useCommentDelimiters;
   
    public static void main(String[] args) throws FileNotFoundException
    {
        // "-c" option places line numbers inside comment delimiters
        
        for (String arg : args) {
            if (arg.startsWith("-")) {
                if (arg.equals("-c")) {
                    useCommentDelimiters = true;
                }
            }
        }
        // Prompt for the input and output files
        
        Scanner console = new Scanner(System.in);
        System.out.print("Input file: ");
        String inputFileName = console.next();
        System.out.print("Output file: "); 
        String outputFileName = console.next();
        
        // Construct the Scanner and PrintWriter objects for reading and writing
        
        File inputFile = new File(inputFileName);
        Scanner in = new Scanner(inputFile);
        PrintWriter out = new PrintWriter(outputFileName);
        
        // Read the input and write the output
        
        int lineNumber = 1;
        while (in.hasNextLine()) {
            String line = in.nextLine();
            out.println("/*" + lineNumber + "*/" + line);
            lineNumber++;
        }
        in.close();
        out.close();
        }
    }
