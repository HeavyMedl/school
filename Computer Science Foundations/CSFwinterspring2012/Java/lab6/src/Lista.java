public class Lista {
	Object element;
	Lista tail;

	public Lista() {
		element = null;
		tail = null;
	}

	private Lista(Object o, Lista t) {
		element = o;
		tail = t;
	}

	public boolean isEmpty() {
		return element == null && tail == null;
	}

	public Object head() {
		return element;
	}

	public Lista tail() {
		return tail;
	}

	public Lista cons(Object o) {
		Lista newList = new Lista(o, this);
		return newList;
	}

	public int len() {
		int i = 0;
		Lista lp = this;
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

	public Lista append( Lista b) {
		if (isEmpty()) {
			element =  b.element;
			tail = b.tail;
			return this;
		}

		Lista lp = this;

		while (!lp.tail.isEmpty())
			lp = lp.tail;

		lp.tail = b;
		return this;
	}

	public Object  nth(int n) {
		int i = 0;
		Lista lp = this;

		for(; i<n; i++) 
			lp = lp.tail;

		return lp.element;
	}


	public Object find(Object it) {
		Lista lp = this;
		while (!lp.isEmpty() && !lp.element.equals(it))
				lp = lp.tail;

		if (lp.isEmpty())
			return null;
		else
			return lp.element;
	}
}