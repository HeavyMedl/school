
public class ListArray implements List {
	Object[] elements;
	int size;
	int top;

	public ListArray() {
		elements = new Object[25];
		size = 0;
		top = -1;
	}


	public boolean isEmpty() {
		return size == 0;
	}

	public Object head() {
		return elements[top];
	}

	public ListArray tail() {
		--top;
		--size;
		return this;
	}

	public ListArray cons(Object o) {
		elements[++top] = o;
		++size;
		return this;
	}

	public int len() {
		return size;
	}


}
