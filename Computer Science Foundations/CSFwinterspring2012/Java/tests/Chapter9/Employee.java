public class Employee  {
  private String name;
  private String department;
  private int salary;
  
  public Employee(String aName, String aDep, int aSal) {
    name = aName;
    department = aDep;
    salary = aSal;
  }
  
  public String toString() {
    return getClass().getName() + "[Name= " + name + "Department= " + department
                + "Salary= " + salary + "]";
  }
}