public class RoachPopulation
{
  private double population;
  private double sprayedpopulation;
  
  public RoachPopulation()
  {
    population = 0;
    sprayedpopulation = 10;
  }
  
  public RoachPopulation(double initialpopulation, double thesprayedpopulation)
  {
    population = initialpopulation;
    sprayedpopulation = thesprayedpopulation;
  }
  
  public double breed()
  {
    double populationdouble = population * 2;
    population = populationdouble;
    return population;
  }
  
  public double spray()
  {
    double tenpercent = population * (sprayedpopulation / 100);
    population = population - tenpercent;
    return population;
  }
  
  public double getRoaches()
  {
    return population;
  }
  
  public static void main(String [] args)
  {
    RoachPopulation roachsimulation = new RoachPopulation(10, 10);
    System.out.println("Initial roach population:  " + roachsimulation.getRoaches());
    System.out.println("Roach population doubles: " + roachsimulation.breed());
    System.out.println("Roach population reduced by 10%: " + roachsimulation.spray());
    System.out.println("Roach population doubles: " + roachsimulation.breed());
    System.out.println("Roach population reduced by 10%: " + roachsimulation.spray());
    System.out.println("Roach population doubles: " + roachsimulation.breed());
    System.out.println("Roach population reduced by 10%: " + roachsimulation.spray());
    System.out.println("Roach population doubles: " + roachsimulation.breed());
    System.out.println("Roach population reduced by 10%: " + roachsimulation.spray());
  }

}
    
    
    
    