import java.util.Scanner;

public class HighestTemperature
{
  private int maxmonth;
  private double maxtemp;


public HighestTemperature() {
  maxmonth = 0;
  maxtemp = 0;
}

public void highesttemp()
{
  Scanner s = new Scanner(System.in);
  
  for (int cm = 0; cm < 12; cm++) {
    System.out.print("Enter temp: ");
    double temp = s.nextDouble();
    if (cm == 0) {
      maxtemp = temp;
      maxmonth = cm; }
    else if (temp > maxtemp) {
      maxtemp = temp;
      maxmonth = cm; }
  }
}

public int getMaxMonth() {
  return maxmonth;
}
public double getMaxTemp() {
  return maxtemp;
}
}


    