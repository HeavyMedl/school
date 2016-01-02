
public class TestDistance {

	public static void main(String[] args){
		double[] a = {0,0,0,0};
		double[] b = {2,2,2,2};
		NamedVectorInstance aI = new NamedVectorInstance(a);
		NamedVectorInstance bI = new NamedVectorInstance(b);
		
		KmeansClusterer km = new KmeansClusterer(null, 1);
		System.out.println(km.distance(aI, bI));
	}
	
	
}
