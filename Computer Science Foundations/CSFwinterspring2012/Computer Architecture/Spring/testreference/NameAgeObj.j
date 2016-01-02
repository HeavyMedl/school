.class public NameAgeObj
.super java/lang/Object

.field public name Ljava/lang/String;
.field public age I

;standard initializer
.method public <init>()V
        aload_0
        invokespecial java/lang/Object/<init>()V
        return
.end method

.method public <init>(Ljava/lang/String;I)V
        .limit stack 2
        .limit locals 3
        aload_0
        invokespecial java/lang/Object/<init>()V

        aload_0
        aload_1
        putfield NameAgeObj/name Ljava/lang/String;

        aload_0
        iload_2
        putfield NameAgeObj/age I

        return
.end method

;create a print pair method

.method public printNameAge()V
        .limit stack 3

        getstatic java/lang/System/out Ljava/io/PrintStream;
        aload_0
        getfield NameAgeObj/name Ljava/lang/String;
        invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V

        getstatic java/lang/System/out Ljava/io/PrintStream;
        ldc " "
        invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V

        getstatic java/lang/System/out Ljava/io/PrintStream;
        aload_0
        getfield NameAgeObj/age I
        invokevirtual java/io/PrintStream/println(I)V

        return
.end method
