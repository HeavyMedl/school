
// A Vector Class that allows for a name/label to be applied
// Used to hold "instances" as well as to hold the centroids for the clusters.

public class NamedVectorInstance {

	double[] array;
	String name;
	
	// create a VectorInstance by passing in an array of doubles
	public NamedVectorInstance(double[] in){
		array = new double[in.length];
		for(int i = 0; i < in.length; i++){
			array[i]= in[i];
		}
	}
	
	// creates an all zero vector of the specified size
	// thanks Josh and Colin!
	public NamedVectorInstance(int size){
		array = new double[size];
		for (int i = 0; i < array.length; i++ ){
			array[i]=0.0;
		}
	}
		
	// adds the values of this instance to the values of the parameter and
	//returns a new Instance. does not modify the original
	public NamedVectorInstance add(NamedVectorInstance other){
		NamedVectorInstance sum = new NamedVectorInstance (array.length);
		for(int i = 0; i < array.length; i++){
			sum.set(i, this.get(i) + other.get(i));
		}
		return sum;
	}
	
	// subtract a vector from from this vector, return a new vector with the differences
	public NamedVectorInstance subtract(NamedVectorInstance subtrahend){
		NamedVectorInstance difference = new NamedVectorInstance (array.length);
		for(int i = 0; i < array.length; i ++){
			difference.set(i, this.get(i) - subtrahend.get(i));
		}
		return difference;
	}
	
	// make a copy of the vector
	public NamedVectorInstance clone(){
		NamedVectorInstance i = new NamedVectorInstance(array.length);
		i = i.add(this);
		i.setName(this.getName());
		return i;
		
	}
	
	// return the size of the vector
	public int size(){
		if (array !=null)
			return array.length;
		else 
			return -1;
	}
	
	// return the element at the specified position
	public double get(int index){
		return array[index];
	}
	
	// set the element at position index to have the value value
	public void set(int index, double value){
		array[index] = value;
	}

	// divide this vector by the specified integer, return a new vector
	public NamedVectorInstance divide(int divisor) {
		NamedVectorInstance ret = new NamedVectorInstance(new double[array.length]);
		for(int i = 0 ; i < array.length; i++){
			ret.set(i, this.get(i)/divisor);
		}
		return ret;
	}
	
	// create a string representing the array and the vector's label
	public String toString(){
		String ret = "";
		for (int i = 0; i < array.length; i++){
			ret = ret + this.get(i) + ",";
		}
		if (name !=null)
			ret = ret + this.name ;
		return ret + "\n";
	}
	
	//setter for name
	public void setName(String nm){
		this.name = nm;
	}
	
	// return the name/ labe of this vector
	public String getName(){
		return this.name;
	}
}
