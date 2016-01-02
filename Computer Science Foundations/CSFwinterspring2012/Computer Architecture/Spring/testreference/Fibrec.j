.class public Fibrec
.super java/lang/Object

.method public <init>()V
	aload_0
	invokespecial java/lang/Object/<init>()V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 4
	.limit locals 3

	getstatic java/lang/System/out Ljava/io/PrintStream;

	aload_0
	iconst_0
	aaload
	invokestatic java/lang/Integer.parseInt(Ljava/lang/String;)I
	
	;call the static method "fibgen" to compute the fib number
	invokestatic Fibrec/fibgen(I)I

	;print the result
	invokevirtual java/io/PrintStream/println(I)V
	
	return
.end method

.method public static fibgen(I)I
	.limit stack 2
	;.limit locals 1

	iload_0		;check if argument <= 0
	ifle Exit0	;if so, return 0

	iload_0
	iconst_1
	if_icmpeq Exit1
	
	
	iinc 0 -1	;push n, store (n-1)
	iload_0		;push (n-1)
	invokestatic Fibrec/fibgen(I)I
	iinc 0 -1	;push (n-1), store (n-2)
	iload_0		;push (n-2)
	invokestatic Fibrec/fibgen(I)I

	iadd
	ireturn	



Exit0:
	iload_0
	goto Done

Exit1:
	iload_0
	goto Done

Done:
	ireturn
.end method
