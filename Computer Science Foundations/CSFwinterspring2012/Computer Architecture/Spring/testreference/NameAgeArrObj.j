.class public NameAgeArrObj
.super java/lang/Object

;standard initializer
.method public <init>()V
        aload_0
        invokespecial java/lang/Object/<init>()V
        return
.end method

.method public static main([Ljava/lang/String;)V
        .limit stack 4
        .limit locals 9         ;#0 args array address
                                ;#1 args array length
                                ;#2 args array loop counter
                                ;#3 array of objects loop counter
                                ;#4 array of objects
                                ;#5 Pair Object
                                ;#6 added var for array of objects arraylength
				;#7 1st constructor value
				;#8 2nd constructor value			
					

        iconst_0                ;load 0 for args array loop counter
        istore_2                ;store in loc var 2

        iconst_0                ;load 0 for array of objects loop counter
        istore 3                ;store in loc var 3

        aload_0			;reference to args array
        arraylength             ;length of the args array
        istore_1                ;store in loc var 1

        iload_1                 ;load args arraylength for size of array of objects
        iconst_2                ;load const 2 for division
        idiv                    ;divide by half of the args arraylength to compensate for the fact
                                ;that each object in Array of objects will hold 2 args within their fields
                                ;Thus, 2 cmd line args will fill one object, which will fill one slot in array.
        anewarray NameAgeObj    ;instruction for array of objects of type NameAgeObj
        astore 4                ;store in loc var 4

        aload 4                 ;;load array of objects
        arraylength             ;;take array of objects' length
        istore 6                ;;store in loc var 6

	;CHECK for more than 0 arguments
        iload_1                 ;load args arraylength
        ifle Usage              ;if args array length <= 0, goto Usage

        ;CHECK for even number of arguments
        iload_1                 ;load args arraylength
        iconst_2                ;load 2 for even comparison
        irem                    ;push the remainder (arraylength % 2)
        ifeq Top                ;if (arraylength % 2 == 0), goto Top

Usage:
        getstatic java/lang/System/out Ljava/io/PrintStream;
        ldc "Usage: java NameAgeArrObj <even number of inputs>"
        invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
        goto Done

Top:
        ;create a new NameAgeObj object, take 1 command line argument and fill
        ;the first field of type String, increment loop counter (to
        ;reference the second command line arguement) and fill the
        ;the second field of type int, increment loop counter. Insert object
        ;into the correct positions within the Array of Objects.

        iload_2                 ;load args array loop counter for comparison
        iload_1                 ;load args arraylength for comparison
        if_icmpge PrintStep1    ;if args array loop counter >= arraylength, goto PrintStep1

	;New pair object, store first command line arg and fill first field

	;new NameAgeObj
	;astore 5
	
	
	aload_0
	iload_2
	aaload
	astore 7		;store String in loc var 7

	iinc 2 1
	
	aload_0
	iload_2
	aaload
	invokestatic java/lang/Integer.parseInt(Ljava/lang/String;)I
	istore 8		;store integer in loc var 8
	
	new NameAgeObj
	astore 5

	aload 5			;NameAgeObj object reference
	aload 7			;The String stored in loc var 7
	iload 8			;The integer stored in loc car 8
	invokespecial NameAgeObj/<init>(Ljava/lang/String;I)V

	iinc 2 1

        ;;new NameAgeObj
        ;;dup
        ;;invokespecial NameAgeObj/<init>()V
        ;;astore 5

        ;;aload 5
        ;;aload_0                 ;load args array address from #0
        ;;iload_2                 ;load args array loop counter (start = 0)
        ;;aaload                  ;load address of string from array of addy's

        ;;putfield NameAgeObj/name Ljava/lang/String;

        ;;iinc 2 1                ;increment the loop counter by 1

        ;store the second command line arg and fill the second field
        ;;aload 5
        ;;aload_0                 ;load args array address from #0
        ;;iload_2                 ;load args array loop counter (start = 1)
        ;;aaload                  ;load address of string from array of addy's
        ;;invokestatic java/lang/Integer.parseInt(Ljava/lang/String;)I

        ;;putfield NameAgeObj/age I

        ;;iinc 2 1                ;args array loop counter is now 2

	;Store NameAgeObj object in appropriate index of array of objects
        aload 4                 ;array of objects
        iload 3                 ;array of objects loop counter
        aload 5                 ;load the value to fill the array
        aastore                 ;set the array[location] with value (NameAgeObj object)

        iinc 3 1                ;increment the array of objects loop counter so the next
                                ;NameAgeObj object can occupy the next array slot

        goto Top

PrintStep1:

        ;reset array of objects loop counter
        iconst_0
        istore 3

PrintFinal:

        iload 3                 ;load array of objects loop counter for comparison
        iload 6                 ;;load array of objects' length
        if_icmpge Done          ;if index >= arraylength goto Done

        ;Print the field "name" from NameAge object in Array of Objects
        aload 4                 ;load the array of objects stored in local 4
        iload 3                 ;load array of objects loop counter
        aaload                  ;extract and push the object onto the stack

        invokevirtual NameAgeObj/printNameAge()V

	iinc 3 1

	goto PrintFinal

Done:
	return
.end method
