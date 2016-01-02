package bfs;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Graph {
    ArrayList<Edge> edges = new ArrayList<>();
    ArrayList<Label> labels = new ArrayList<>();
    
    // A graph contains a a list of edges and a list of labels
    public Graph(ArrayList<Edge> es, ArrayList<Label> lbs) {
        edges = es; labels = lbs;
    }
    // Return the edges array list of a graph.
    public ArrayList<Edge> getEdges() {
        return this.edges;
    }
    // Return the labels array list of a graph.
    public ArrayList<Label> getLabels() {
        return this.labels;
    }
    // Give a representation of a "Graph"
    @Override
    public String toString() {
        String graph = "Graph Edges: " + this.edges + "\n" +
                       "Graph Labels: " + this.labels;
        return graph;
    }
    // Test if two vertices are adjacent in a graph
    public Boolean isAdj(String x, String y) {
        Boolean value = false;
        for(Edge e : edges) {
            if (x.equals(e.getNode1()) && y.equals(e.getNode2()) ||
                x.equals(e.getNode2()) && y.equals(e.getNode1()))
                value = true; }
        return value;
    }
    // Return the vertices of a graph
    public ArrayList<String> vertices() {
        Set<String> vertices = new HashSet<>();
        for(Edge e : edges) {
            vertices.add(e.getNode1());
            vertices.add(e.getNode2());
        }
        return new ArrayList<>(vertices);
    }
    // Return an adjacency list of a vertex x
    public ArrayList<String> adjacencyList(String x) {
        ArrayList<String> adjList = new ArrayList<>();
        for(Edge e : edges)
            if (x.equals(e.getNode1()))
                adjList.add(e.getNode2());
        return adjList;
        
    }
    // Test if a vertex x has a label assigned to it
    public Boolean hasLabel(String x) {
        Boolean value = false;
        for(Label l : labels){
            if (x.equals(l.getName()))
                value = true;
        }
        return value;
    }
    // Assign a label l to a graph
    public void assign(Label l) {
        labels.add(l);
    }
    // Assign multiple labels, ls, to a graph
    public void assignLabels(ArrayList<Label> ls) {
        for(Label l : ls)
            this.assign(l);
    }
    // Return a label of the designated vertex from labels
    public int getLabel(String x) {
        int label = 0;
        for(Label l : labels)
            if (x.equals(l.getName()))
                label = l.getLabel();
        return label;
    }
    // Return a pred of the designated vertex from labels
    public String getPred(String x) {
        String pred = "";
        for(Label l : labels)
            if (x.equals(l.getName()))
                pred = l.getPred();
        return pred;
    }
    // Test if all the vertices are labeled.
    public Boolean allLabeled(ArrayList<String> vls) {
        Boolean value = true;
        for(String v : vls)
            if (!this.hasLabel(v))
                value = false;
        return value; 
    }
    /* enlarge : enlarge the labeling of a graph with 
     * an initial root; L = {S} aka L contains the label
     * "Label S (0,-)"
     */
    public Graph enlarge(ArrayList<String> vls, Graph g) {
        ArrayList<String> adj;
        ArrayList<String> newAdj = new ArrayList<>();
        String pred;   
            for(String v : vls) {
                newAdj.addAll(g.adjacencyList(v));
            }
            if (g.allLabeled(newAdj))
                return g;
            else
                for(String v : vls) { 
                    adj = g.adjacencyList(v);
                    pred = v;
                    for(String s : adj)
                        if (!g.hasLabel(s) && !s.equals("S"))  
                        g.assign(new Label (s,(g.getLabel(pred) + 1),v));  
        }
        return enlarge(newAdj, g);
        
    }
    // Construct a shortest path to a vertex
    public ArrayList<String> shortestPath(String x, ArrayList<String> list) {
        ArrayList<String> temp = new ArrayList<>();
        temp.add(x);
        temp.addAll(this.predList(x,list));
        Collections.reverse(temp);
        return temp;
    }
        private ArrayList<String> predList(String x, ArrayList<String> list) {
            if (x.equals("S")) {
                return list;
            }
            else
                list.add(this.getPred(x));
            return predList(this.getPred(x), list);
        }
}
