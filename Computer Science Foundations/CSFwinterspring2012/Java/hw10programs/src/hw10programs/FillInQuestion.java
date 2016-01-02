package hw10programs;

/**
 *
 * @author kurtmedley
 */
public class FillInQuestion extends Question {
    
    public FillInQuestion(String questionText) {
        super(questionText);
    }
    
    @Override
    public void display() {
        super.display();
        System.out.print(" _____");
    }
}
