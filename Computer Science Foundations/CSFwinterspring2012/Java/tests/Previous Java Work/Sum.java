public class Sum {
  
  private int sum;
  
  public Sum(int aSum) {
    sum = aSum;
  }
  
  public int addUp() {
    int total = 0;
    for (int i = 0; i <= sum; i++) {
      total = total + i; }
    return total;
  }
    
  public static void main(String[] args) {
    Sum test = new Sum(5);
    System.out.println(test.addUp());
  }
  }

