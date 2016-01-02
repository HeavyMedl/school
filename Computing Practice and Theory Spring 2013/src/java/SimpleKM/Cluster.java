import java.util.ArrayList;


// object that contains a centroid as well as a list of instances that found the centroid to be the closest

public class Cluster {

	NamedVectorInstance centroid;
	NamedVectorInstance oldCentroid;
	ArrayList<NamedVectorInstance> members = new ArrayList<NamedVectorInstance>();

	ArrayList<String> labels = new ArrayList<String>();
	ArrayList<Integer> counts = new ArrayList<Integer>();

	public Cluster(NamedVectorInstance i){
		oldCentroid = new NamedVectorInstance(new double[i.size()]);
		this.centroid = i.clone();
	}

	// add an instance to the cluster
	public void add(NamedVectorInstance instance){
		updateLabelCount(instance.getName());
		members.add(instance);
	}

	// return the current cetroid of the cluster
	public NamedVectorInstance getCentroid() {
		return centroid;
	}

	// return the previous centroid for the cluster 
	public NamedVectorInstance getOldCentroid(){
		return oldCentroid;
	}

	// remove the instances from the cluster and reset other information about the cluster
	public void purge(){
		labels = new ArrayList<String>();
		counts = new ArrayList<Integer>();
		members = new ArrayList<NamedVectorInstance>();	
	}

	
	// recalculate the centroid as the average of the instances assigned to the cluster
	public void updateCentroid() {
		oldCentroid = centroid.clone();

		// Coding Step 3
	}

	// Return the number of instances assigned to the cluster
	public int size(){
		return members.size();
	}

	// create a String representation of the cluser
	public String toString(){
		String ret = "\n\tCluster Centroid: \n" + centroid + "\n"+ "\tCluster Composition: \n";
		ret = ret + labelPercentages();
		ret = ret + "\n";		
		ret = ret + "\tCluster Members: \n" ;
		for (NamedVectorInstance i : members)
			ret = ret + i;
		
		return ret;
	}

	// count the labels of the instances assgined to the cluster
	private void updateLabelCount(String name) {
		int i =0;
		for(i = 0; i < labels.size(); i ++){
			if (labels.get(i).equals(name)){
				counts.set(i, counts.get(i) + 1);
				return;
			}
		}
		labels.add(name);
		counts.add(1);
	}
	
	// create a string identifying the composition (as a percent) of each cluster.
	public String labelPercentages(){
		String ret="";
		Double size = (double) members.size();
		int i = 0;
		for (String s: labels){
			ret = ret + s + " ";
			double count = counts.get(i);
			ret = ret + " "+(count/size)*100 + " %";
			ret = ret + "\n";
			i++;
		}
		return ret;
	}
}
