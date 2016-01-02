public class DataSetTester {
  public static void main(String[] args) {
    
    DataSet bankaccounts = new DataSet();
    
    bankaccounts.add(new BankAccount(1000));
    bankaccounts.add(new BankAccount(500));
    bankaccounts.add(new BankAccount(5));
    System.out.println(bankaccounts.getAverage());
    Measurable max = bankaccounts.getMaximum();
    System.out.println(max.getMeasure());
    
    
    DataSet diestuff = new DataSet();
    Die d1 = new Die(6);
    d1.cast();
    Die d2 = new Die(6);
    d2.cast();
    Die d3 = new Die(6);
    d3.cast();
    diestuff.add(d1);
    diestuff.add(d2);
    diestuff.add(d3);
    System.out.println("Average: " + diestuff.getAverage());
    max = diestuff.getMaximum();
    Measurable min = diestuff.getMinimum();
    System.out.println("Minimum: " + min.getMeasure());
    System.out.println("Maximum: " + max.getMeasure());
    
    DataSet gradestuff = new DataSet();
    Quiz q1 = new Quiz(100);
    Quiz q2 = new Quiz(75);
    Quiz q3 = new Quiz(80);
    gradestuff.add(q1);
    gradestuff.add(q2);
    gradestuff.add(q3);
    System.out.println("Quiz Average: " + gradestuff.getAverage());
    max = gradestuff.getMaximum();
    System.out.println("Highest Score: " + max.getMeasure());
    Quiz g = (Quiz) max;
    System.out.println("Grade: " + g.getGrade());
    
    System.out.println(gradestuff.compareTo(diestuff));
   
  }
}