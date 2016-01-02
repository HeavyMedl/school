public class Numeric
{
  public static double intPower(double x, int n)
  {
    double result = 0;
    if (n > 0) {
      result = 1 / (Math.pow(x, -n)); }
    if (n > 0 && n % 2 == 0) {
      result = Math.pow(Math.pow(x,n/2),2); }
    if (n > 0 && n % 2 == 1) {
      result = x * Math.pow(x, n-1); }
    return result;
    }
}