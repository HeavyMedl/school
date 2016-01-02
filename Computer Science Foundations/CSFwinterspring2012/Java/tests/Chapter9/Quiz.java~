public class Quiz implements Measurable {
	private double score;
	private String grade;
	
	// Implement the interface
	public double getMeasure() {
		return score;
	}
	
	public Quiz(int aNum){
		score = aNum;
		grade = null;
	}
	
	public String getGrade() {
		if (score >= 100)
		{ grade = "A+";}
		else if (score >= 90)
		{ grade = "A";}
		else if (score >= 85)
		{ grade = "B+";}
		else if (score >= 80)
		{ grade = "B";}
		else if (score >= 75)
		{ grade = "C+";}
		else if (score >= 70)
		{ grade = "C";}
		else if (score >= 65)
		{ grade = "D+";}
		else if (score >= 60)
		{ grade = "D";}
		else
			grade = "F";
		return grade;
	}
}
	