public interface List
{
  Object head();
  List tail();
  List cons(Object o);
  boolean isEmpty();
  int len();
}