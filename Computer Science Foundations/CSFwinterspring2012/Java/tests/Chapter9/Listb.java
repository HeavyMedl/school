public class Listb implements List
{
  Object element;
  Listb tail;

  public Listb()
  {
    element = null;
    tail = null;
  }

 private Listb(Object o, Listb t) {
  element = o;
  tail = t;
 }

 public boolean isEmpty() {
  return element == null && tail == null;
 }

 public Object head() {
  return element;
 }

 public Listb tail() {
  return tail;
 }

 public Listb cons(Object o) {
  Listb newList = new Listb(o, this);
  return newList;
 }

 public int len() {
  int i = 0;
  Listb lp = this;
  while (!lp.isEmpty()) {
   i++;
   lp = lp.tail;

  }
  return i;
 }

 public int rlen() {
  if (isEmpty())
   return 0;
  else
   return 1 + tail.rlen();
 }

}
