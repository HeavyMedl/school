 /** A class usable for analyzing objects of any class that implements the
   * Measurable interface
   **/

public class DataSet implements Comparable {
  private double sum;
  private Comparable maximum;
  private Comparable minimum;
  private int count;
  
  public int compareTo(Object obj) {
    if (this.maximum == ((DataSet) obj).maximum ||
        this.minimum == ((DataSet) obj).minimum)
      return 0;
    else if (this.getMaximum() > ((DataSet) obj).getMaximum() ||
             this.getMinimum() > ((DataSet) obj).getMinimum())
      return 1;
    else
      return -1;
  }
               
  void add(Comparable x) {
    if (minimum == null || x.compareTo(minimum) < 0)
      minimum = x;
    if (maximum == null || x.compareTo(maximum) > 0)
      maximum = x;
  }
  
  public Comparable getMinimum() {
    return minimum;
  }
  
  public Comparable getMaximum() {
    return maximum;
  }
  
  public double getAverage() {
    sum = sum / count;
    return sum;
  }
}
                    