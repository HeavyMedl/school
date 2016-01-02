/*
 * A Breadth-First Search 
 * Discrete Mathematics 5th edition by Dossey et al. (pg 183)
 * (c) Kurt Medley
 */
package bfs;

import java.util.ArrayList;
import java.util.Arrays;

/**
Step 1 (label S)
    (a) Assign S the label 0, and let S have no predecessor.
    (b) Set L = {S} and k = 0.
Step 2	(label vertices)
    repeat
        Step 2.1 (increase the label)
            Replace k with k+1
        Step 2.2 (enlarge labeling)
            while L contains a vertex V with label k-1 
            that is adjacent to a vertex W not in L
		(a) Assign the label k to W.
		(b) Assign V to be the predecessor of W.
		(c) Include W in L 
                endwhile
            until no vertex in L is adjacent to a vertex not in L
Step 3	(construct a shortest path to a vertex)
	if a vertex T is in L
            The label on T is its distance from S. A shortest path from S to T
            is formed by taking in reverse order T, the predecessor of T, the 
            predecessor of the predecessor of T, and so forth, 
            until S is reached.
        otherwise
            There is no path from S to T.
		endif
 */
public class BFS {

    public static void main(String[] args) {
        ArrayList<String> vertLabels = new ArrayList<>();        
        
        // initialize a graph with edges and no labels
        ArrayList<Label> ls = new ArrayList<>(); 
        ArrayList<Edge> es = new ArrayList<>(Arrays.asList
        (new Edge("S","A"),new Edge("S","B"),new Edge("A","E"),new Edge("A","C"),
         new Edge("A","S"),new Edge("B","S"),new Edge("B","C"),new Edge("B","D"),
         new Edge("C","E"),new Edge("C","H"),new Edge("D","G"),new Edge("E","C"),
         new Edge("E","F"),new Edge("F","E"),new Edge("F","H"),new Edge("G","J"),
         new Edge("H","C"),new Edge("H","F"),new Edge("H","I"),new Edge("I","H"),
         new Edge("I","J"),new Edge("J","I"),new Edge("J","G"),new Edge("K","L"),
         new Edge("K","M"),new Edge("L","K"),new Edge("L","M"),new Edge("M","K"),
         new Edge("M","L")));

        Graph graph = new Graph(es, ls);
        
        // Step 1 (a) : Assign S the label 0, and let S have no predecessor.       
            graph.assign(new Label("S",0,"-"));
        // Step 1 (b) : Set L = {S}
            vertLabels.add("S");
        // Step 2 : enlarge labeling
            graph.enlarge(vertLabels, graph);
        // Step 3 : Construct a shortest path to a vertex.
        try {
            ArrayList<String> path = new ArrayList<>();
            System.out.println("Shortest Path to J: " + graph.shortestPath("e", path));
        
        } catch (StackOverflowError e) {
            System.out.println
            ("Vertex does not exist or there is no path. Case sensitive");
        }
        
        System.out.println(graph.toString());
        
    }
}
