import java.lang.Character;
public class Len {
	
	private String s;
	
	public Len(String aS) {
		s = aS;
	}
	
	public int strlen() {
		int i = 0; s = s;
		while (Character.isLetterOrDigit(s.charAt(i))
			|| Character.isWhitespace(s.charAt(i))) {
		i++; }
	return i;
	}

	public static void main(String [] args) {
	
	Len test = new Len("thiss is a test");
	System.out.println(test.strlen());
	}
}
