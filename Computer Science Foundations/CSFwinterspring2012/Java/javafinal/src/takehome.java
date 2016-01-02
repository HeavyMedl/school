public class takehome
{
    /* returns the reversal -- normal */
    public static String rev(String s) {
        String reversed = "";
        int pointer = s.length()-1;
        
        for (int i = 0; i < s.length(); i++) {
                reversed = reversed + s.charAt(pointer);
                pointer--;
             }
        
        return reversed;
        }
    
    /* returns the reversal -- recursive */
    public static String rrev(String s) {
        int end = s.length()-1;
        if (s.length() == 0) {
            return s; }
        else
            return s.substring(end) +
                    rrev(s.substring(0,end));
            
        }
    
    /* returns the largest char - recursive */
    public static char largest(String s) {
        int end = s.length()-1;
        if (s.length() == 1) {
            return s.charAt(0); }
        else
            return largest(s.substring(end)); 
    }
    
    /* returns the smallest char - recursive */
    public static char smallest(String s) {
        int end = s.length()-1;
        if (s.length() == 1) {
            return s.charAt(0); }
        else
            return smallest(s.substring(0,end));
        
    }
    
    /* append two strings - recursive */
    public static String append(String s1, String s2) {
        if (s1.length() == 1) {
            return s2; }
        else if (s2.length() == 1) {
            return s1; }
        
        return s1 + append(s1.substring(s1.length()-1),s2);
        }
    
    /* returns the nth character in a string */
    public static char nth(int n, String s1) {
        if (s1.isEmpty()) {
            return 0; }
        else
            return nth(n, s1.substring(n,n)); 
            
    }
    
                    
                   
        
    
    
    public static void main(String[] args) throws Exception {
        String test = "This is a test.";
        String num = "0123456789";
        String one = "1";
        System.out.println("Regular rev: "+rev(test));
        System.out.println("Recursive rev: "+rrev(test));
        System.out.println("Largest Char: "+largest(one));
        System.out.println("Smallest Char: " +smallest(test));
        System.out.println("Append Strings: "+ append(test,num));
        System.out.println("Find nth char: "+ nth(5,test));
    }
}
 
