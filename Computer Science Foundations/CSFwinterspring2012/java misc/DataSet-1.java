import java.util.Scanner;

public class DataSet {
	private double sum;
	private int cnt;

	public DataSet() {
		sum = 0;
		cnt = 0;
	}

	public void add(double d) {
		sum += d;
		cnt++;
	}

	public double sum() {
		return sum;
	}

	public static boolean enterInp(String answer, String prompt,
			DataSet data, Scanner in) {
		String input;

		System.out.print(prompt);
		input = in.next();
		if (input.equalsIgnoreCase(answer))
			return false;
		else {
			data.add(Double.parseDouble(input));
			return true;
		}
	}

	public static void main(String args[] ) {
		DataSet d = new DataSet();

		Scanner s = new Scanner(System.in);

		while (enterInp("Q", "Enter val, Q to quit: ", d, s) )
			;

		System.out.println("Here is the sum: " + d.sum());

		while (s.hasNextDouble())
			System.out.println("Here it is: " + s.nextDouble());

		System.out.println("Here is terminating string: " + s.next());
	}

}
