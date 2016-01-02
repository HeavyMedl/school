/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hw10programs;
import java.util.Scanner;
/**
 *
 * @author kurtmedley
 */
public class QuestionDemo {
    
    public static void main(String[] args) {
        
        Question[] quiz = new Question[3];
        
        quiz[0] = new Question("Who was the inventor of Java?");
        quiz[0].setAnswer("James Gosling");
        
        quiz[1] = new FillInQuestion("The inventor of Java was");
        quiz[1].setAnswer("_James Gosling_");
        
        ChoiceQuestion question = new ChoiceQuestion(
                "In which country was the inventor of Java born?");
        question.addChoice("Australia", false);
        question.addChoice("Canada", true);
        question.addChoice("Denmark", false);
        question.addChoice("United States", false);
        quiz[2] = question;
        
        Scanner in = new Scanner(System.in);
        for (Question q : quiz)
        {
            q.display();
            System.out.println("Your answer: ");
            String response = in.nextLine();
            System.out.println(q.checkAnswer(response));
           
        }
        System.out.println(quiz[0].toString());
        Question mimick = quiz[0];
        System.out.println("Are they equal? [T]" + quiz[0].equals(mimick));
        
        System.out.println(quiz[2].toString());
        ChoiceQuestion mimick2 = question;
        System.out.println(quiz[2].equals(question));
        
    }
        
          
    
}
    