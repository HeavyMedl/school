public class LeapYear
{
  private int year;
  
  public LeapYear(int aYear) {
      year = aYear;
    }
    
    public boolean isLeapYear() {
      boolean leapyear = false;
      boolean c1 = ((year % 4) == 0);
      boolean c2 = ((year % 100) == 0);
      boolean c3 = ((year % 400) == 0);
      if (c2) {
        if (c3) {
          leapyear = true; }
        else {
          leapyear = false; } }
      else if (c1) {
        if (c2) {
          leapyear = false; }
        else {
          leapyear = true; } }
      return leapyear;
    }
    
  }
        