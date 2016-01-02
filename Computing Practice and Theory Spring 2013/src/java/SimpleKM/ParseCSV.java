import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

// Parse the glass.csv file from disk, has to be in Weka form with all numeric, and the last attribute a label
// You do not need to modify this file
public class ParseCSV {
	

	BufferedReader bufferedReader ;
	ParseCSV(){
		bufferedReader = null;
	}
	
	public ArrayList<NamedVectorInstance> getInstances(String locationOnDisk){
		ArrayList<NamedVectorInstance> instances = new ArrayList<NamedVectorInstance>();
		try {
		
			String currentLine;
			bufferedReader = new BufferedReader(new FileReader(locationOnDisk));
		
			while((currentLine = bufferedReader.readLine()) != null){
				//System.out.println(currentLine);
				String[] values = currentLine.split(",");
				int size = values.length-1;
				NamedVectorInstance inst = new NamedVectorInstance(new double[size]);
				for(int i = 0; i < size ; i++){
					double d = Double.parseDouble(values[i]);
					inst.set(i, d);					
				}
				inst.setName(values[size]);	
				instances.add(inst);
			}
			
		} catch(IOException e) {
			e.printStackTrace();
		} finally{
			try {
				if (bufferedReader !=null)
					bufferedReader.close();
			} catch(IOException e1) {
				e1.printStackTrace();
			}
		}
		
		return instances;
	}
}
