/*
 * Boolean version
 */

boolean DONE = false;

public int convert() {
int num = 0;
while (!DONE) {
	name = Scanner.next();
	if (!bridgeNameOK(name))
		DONE = TRUE;
	feet = Scanner.nextDouble();
	if (!bridgeLengthOK(feet))
		DONE = TRUE;
	else {
		System.out.println("Bridge data: " + convertFtToM(feet));
		num++;
	}
}
return num;
}

public int convert() {
int num = 0;
while (true) {
	name = Scanner.next();
	if (!bridgeNameOK(name))
		break;
	feet = Scanner.nextDouble();
	if (!bridgeLengthOK(feet))
		break;
	else {
		System.out.println("Bridge data: " + convertFtToM(feet));
		num++;
	}
}
return num;
}

public int convert() {
int num = 0;
while (true) {
	name = Scanner.next();
	if (!bridgeNameOK(name))
		return num ;
	feet = Scanner.nextDouble();
	if (!bridgeLengthOK(feet))
		return num ;
	else {
		System.out.println("Bridge data: " + convertFtToM(feet));
		num++;
	}
}
