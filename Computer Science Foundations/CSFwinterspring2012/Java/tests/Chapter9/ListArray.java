
public class ListArray implements List {
 Object[] elements;
 int size; // is the number of elements
 int top; // last element to put on

 public ListArray() {
  elements = new Object[25];
  size = 0; // size of the array (initialized)
  top = -1; // start at -1 because -1 is not a legal index (for initialization)
 }


 public boolean isEmpty() {
  return size == 0;
 }

 public Object head() {
  return elements[top]; // store whatever elements are 
 }

 // Decrement, return 
 public ListArray tail() {
  --top;
  --size;
  return this;
 }

 // Increment top and increment size, insert element into array
 public ListArray cons(Object o) {
  elements[++top] = o;
  ++size;
  return this;
 }

 public int len() {
  return size;
 }


}
