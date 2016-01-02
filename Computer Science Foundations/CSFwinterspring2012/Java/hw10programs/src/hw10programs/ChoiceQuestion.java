
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hw10programs;
import java.util.ArrayList;
/**
 *A question with multiple choices.
 */
public class ChoiceQuestion extends Question {
    private ArrayList<String> choices;
    
    /**
     * Constructs a choice question with a given text and no choices.
     * @param questionText  the text of this question.
     */
    public ChoiceQuestion(String questionText) {
        super(questionText);
        choices = new ArrayList<String>();
    }
    /**
     * Adds an answer choice to this question.
     * @param  choice the choice to add
     * @param  correct true if this is the correct choice, false otherwise
     */
    public void addChoice(String choice, boolean correct) {
        choices.add(choice);
        if (correct)
        {
            //Convert choices.size() to string
            String choiceString = "" + choices.size();
            setAnswer(choiceString);
        }
    }
    
    public void display()
    {
        //Display the question text
        super.display();
        //Display the answer choices
        for (int i = 0; i < choices.size(); i++)
        {
            int choiceNumber = i + 1;
            System.out.println(choiceNumber + ": " + choices.get(i));
        }
    }
    @Override
    public String toString() {
        int choicenumber = choices.size();
        return super.toString() + "Choices = " + choicenumber;
    }
    
    @Override
    public boolean equals(Object o) {
        if (o == null) {return false;}
        if (getClass() != o.getClass()) { return false; }
        
        ChoiceQuestion q = (ChoiceQuestion) o;
        if (getQuestion().equals(q.getQuestion())) {
            if (choices.equals(q.choices)) {
                return true; }
            else {
                return false; } }
        
        return false;
            
        }
}


        
