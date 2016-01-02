/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hw10programs;

/**
 * A question with a text and an answer.
 */
public class Question {
    private String text;
    private String answer;

/**
 * Constructs a question with a give text and an empty answer.
 * @param questionText the text of this question
 */
    public Question(String questionText) {
        text = questionText;
        answer = "";
    }

/**
 * Sets the answer for this question.
 * @param correctResponse  the answer
 */
    public void setAnswer(String correctResponse) {
        answer = correctResponse;
    }

/**
 * Checks a given response for correctness.
 * @param response  the response to check
 * @return  true if the response was correct, false otherwise.
 */
    public boolean checkAnswer(String response) {
        return response.equals(answer);
    }

/**
 * Displays this question.
 */
    public void display() {
        System.out.println(text);
    }

    @Override
    public String toString() {
        return getClass().getName() + "[Question=" + text + " Answer=" +
            answer + "]";
    }
    
    @Override
    public boolean equals(Object o) {
        if (o == null) { return false; }
        if (getClass() != o.getClass()) { return false; }
        
        Question q = (Question) o;
        return text.equals(q.text) && answer.equals(q.answer); 
    }
    
    public String getQuestion() { 
        return text;
    }
}