public class StringSorter
{
  private String a;
  private String b;
  private String c;
  private String first;
  private String second;
  private String third;
  
  public StringSorter(String aString1, String aString2, String aString3)
  {
    a = aString1;
    b = aString2;
    c = aString3;
    String first;
    String second;
    String third;
  }
  
  public void makeSort()
  {
    // Compute individual values of string A:
    if (a.compareTo(b) < 0 && a.compareTo(c) < 0){
      if (b.compareTo(c) < 0) {
      first = a;
      second = b;
      third = c; }
      else {
        first = a;
        third = b;
        second = c; } }
   else if (a.compareTo(b) < 0 || a.compareTo(c) < 0) {
      if (a.compareTo(b) < 0 && a.compareTo(c) > 0) {
      first = c;
      second = a;
      third = b; }
      else {
        first = b;
        second = a;
        third = c; }}
  // Compute individual values of string B:
   else if (b.compareTo(a) < 0 && b.compareTo(c) < 0){
      if (a.compareTo(c) < 0) {
      first = b;
      second = a;
      third = c; }
      else {
        first = b;
        third = a;
        second = c; } }
   else if (b.compareTo(a) < 0 || b.compareTo(c) < 0) {
      if (b.compareTo(a) < 0 && b.compareTo(c) > 0) {
      first = c;
      second = b;
      third = a; }
      else {
        first = a;
        second = b;
        third = c; }}
   // Compute inidivdual values of string C:
   else if (c.compareTo(a) < 0 && c.compareTo(b) < 0){
      if (b.compareTo(a) < 0) {
      first = c;
      second = b;
      third = a; }
      else {
        first = c;
        third = b;
        second = a; } }
   else if (c.compareTo(b) < 0 || c.compareTo(c) < 0) {
      if (c.compareTo(b) < 0 && c.compareTo(a) > 0) {
      first = a;
      second = c;
      third = b; }
      else {
        first = b;
        second = c;
        third = a; }}
  }
  
  public String getFirst() {
    return first; 
  }
  
  public String getSecond() {
    return second;
  }
  
  public String getThird() {
    return third;
  }
}

