public class UnitConverter
{
  private static double INCHES = 39.27;
  private static double CENTIMETERS = 100;
  private static double MILES = 0.00062;
  private static double FEET = 3.28;
  private static double MILLOMETERS = 1000;
  private static double KILOMETERS = 0.001;
  
  private double base_value;
  private String start_type;
  private String end_type;
  private double start_value;
  private double end_value;
  
  public UnitConverter(String aStart_type, String aEnd_type, double aStart_value)
  {
    base_value = 1;
    start_type = aStart_type;
    end_type = aEnd_type;
    start_value = aStart_value;
    end_value = 0;
  }
  
  public void startConversion()
  {
    if (start_type == "mi") {
      base_value = MILES*start_value; }
    else if (start_type == "cm") {
      base_value = CENTIMETERS*start_value; }
    else if (start_type == "in") {
      base_value = INCHES*start_value; }
    else if (start_type == "ft") {
      base_value = FEET*start_value; }
    else if (start_type == "mm") {
      base_value = MILLOMETERS*start_value; }
    else if (start_type == "km") {
      base_value = KILOMETERS*start_value; }
  }
  
  public double endConversion()
  {
    if (end_type == "mi") {
      end_value = 1/MILES * base_value; }
    else if (end_type == "cm") {
      end_value = 1/CENTIMETERS * base_value; }
    else if (end_type == "in") {
      end_value = 1/INCHES * base_value; }
    else if (end_type == "ft") {
      end_value = (base_value / FEET) / start_value; }
    else if (end_type == "mm") {
      end_value = 1/MILLOMETERS * base_value; }
    else if (end_type == "km") {
      end_value = 1/KILOMETERS * base_value; }
    return end_value;
  }
}
    
      