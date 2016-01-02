.class public arrayLoop
.super java/lang/Object

;boilerplate
.method public <init>()V
	aload_0
	invokespecial java/lang/Object()V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 3
	.limit locals 4		;#0 reserved
				;#1 array
				;#2 index for array
				;#3 index for print
				;#4 arraylength				

	bipush 10		;need 10 elements
	newarray int		;new array of type "I"
	astore_1		;store array in local 1

	iconst_0		;load a 0 for looping
	istore_2		;store index=0 in local 2

FilltheArray:

	aload_1			;load the array
	iload_2			;load the location within the array
	iload_2			;load the value to fill the array
	iastore			;set the array[location] with value

	iinc 2 1		;add 1 to local 2 (index) (location and value)
	
	iload_2			;are we done? (is location >= 10)?
	bipush 10		;load 10 for comparison
	if_icmplt FilltheArray	;if not at 10 yet, jump to FilltheArray and
				;repeat

PrinttheArray:

	iconst_0		;load a 0 for looping
	istore_3		;store index=0 in local 3
	
	aload_1			;load the array
	arraylength		;pop sample, push sample's length
	istore 4		;store arraylength in local 4

	iload_3			;load index for comparison
	iload 4			;load arraylength for comparison
	if_icmpge Done		;if index >= arraylength goto Done

	aload_1			;load the 10 int array stored at 1
	iload_3			;load index corresponding to location 0 to i
	iaload			;extract and push the integer value array[0+]

	;print the contents of the array on a new line
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V

	iinc 3 1		;increment index at #3 by 1

	goto PrinttheArray

Done:
	return
.end method
