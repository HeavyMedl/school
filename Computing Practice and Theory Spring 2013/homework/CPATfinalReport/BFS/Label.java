package bfs;

public class Label {
    String name;
    int label;
    String predecessor;
    
    // Constructs a label of form (name,label,pred)
    public Label(String n, int l, String pred) {
        name = n; label = l; predecessor = pred;
    }
    public String getName() {
        return this.name;
    }
    public int getLabel() {
        return this.label;
    }
    public String getPred() { 
        return this.predecessor;
    }
   
    @Override // Give a representation of "Labels" Object: Label x (lab,pred)
    public String toString(){
        return "Label " + name + " " + "(" + label + "," + predecessor + ")";
    }
   
}
