import java.io.PrintStream;

public class Indent {

	public int l;
	
	public Indent(int pInt) {
	
		l = pInt;
	}

	public void display(String pString) {
		String str = "";
		System.out.println();
		for (int i = 0; i < l; i++)
			str = str + "  ";
		System.out.print(str + pString);
	}
}
