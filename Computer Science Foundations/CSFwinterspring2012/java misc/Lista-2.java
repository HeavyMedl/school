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



	public static void main(String [] args) {
		Lista l = new Lista();
		Lista m = new Lista();

		for (int i=1; i<4; i++)
			l = l.cons(new Integer(i));

		System.out.println("Length is: " + l.len());
		System.out.println("Length is: " + l.rlen());

		Lista l_it = l;

		System.out.println("Here is l");
		while (!l_it.isEmpty() ) {
			System.out.println("| " + l_it.head());
			l_it=l_it.tail();
		}

		m = m.append(l);

		l_it = m;
		System.out.println("Here is m");
		while (!l_it.isEmpty() ) {
			System.out.println("| " + l_it.head());
			l_it=l_it.tail();
		}

		m = new Lista();
		for (int i=1; i<4; i++)
			l = l.cons(new Integer(i));

		m = m.append(l);
		System.out.println("Here is m appended with l");
		l_it = m;
		System.out.println("Here is l");
		while (!l_it.isEmpty() ) {
			System.out.println("| " + l_it.head());
			l_it=l_it.tail();
		}

		System.out.println("Here is the 2nd element: " + m.nth(2));

		System.out.println("Looking for 7: " + m.find(7));
		System.out.println("Looking for 3: " + m.find(3));
		System.out.println("Looking for 101: " + m.find(101));
	}
}
