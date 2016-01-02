package bfs;

public class Edge {
    String node1;
    String node2;
    
    public Edge(String nd1, String nd2){
        node1 = nd1;
        node2 = nd2;
    }
    public String getNode1(){
        return this.node1;
    }  
    public String getNode2(){
        return this.node2;
    }
    @Override
    public String toString(){
        return "(" + node1 + "," + node2 + ")";
    }
}
