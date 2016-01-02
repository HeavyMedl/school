
public class ListTest {

 public static void main(String [] args) {
  Listb l = new Listb();
  ListArray n = new ListArray();

  // Listb; linked list version. Implements head, tail, cons, isEmpty, len
  for (int i=1; i<4; i++)
   l = l.cons(new Integer(i));

  System.out.println("Length is: " + l.len());
  
  // l_lt = "list iterator"
  Listb l_it = l;

  System.out.println("Here is l");
  while (!l_it.isEmpty() ) {
   System.out.println("| " + l_it.head());
   l_it=l_it.tail();
  }
  
  //ListArray; array version. Implements head, tail, cons, isEmpty, len
  for (int i=1; i<4; i++)
   n = n.cons(new Integer(i));

  System.out.println("Length is: " + n.len());

  ListArray n_it = n;

  System.out.println("Here is n");
  while (!n_it.isEmpty() ) {
   System.out.println("| " + n_it.head());
   n_it=n_it.tail();
   
   
   //Interface
   List onelist = new Listb();
   for (int i=0; i<10; i++)
     onelist = onelist.cons(new Integer(i));
  }
  
  

 }
}