.source Triangle.j
.class public Triangle
.super Shape

.field public base I
.field public height I

;standard initializer
.method public <init>()V
	aload_0
	invokespecial java/lang/Object/<init>()V
	return
.end method

.method public <init>(II)V
	.limit stack 2
	.limit locals 3
	aload_0
	invokespecial Shape<init>()V

	
	aload_0
	iload_1
	putfield Triangle/base I

	aload_0
	iload_2
	putfield Triangle/height I

	return
.end method

;create a method to calculate area
.method public area()D
	.limit stack 4
	
	aload_0
	getfield Triangle/base I
	i2d

	aload_0
	getfield Triangle/height I
	i2d
	
	dmul

	ldc2_w 0.5d

	dmul

	dreturn
.end method

;create a printShape() method
.method public printShape()V
	.limit stack 2

	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc "I'm a triangle!"
	invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V

	return
.end method
