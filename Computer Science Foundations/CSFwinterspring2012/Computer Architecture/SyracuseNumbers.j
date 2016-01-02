.class public SyracuseNumbers
.super java/lang/Object

;boilerplate
.method public <init>()V
  aload_0
  invokespecial java/lang/Object/<init>()V
  return
.end method
  
.method public static main([Ljava/lang/String;)V
  .limit stack 2
  .limit locals 3 		; #0 reserved
                      		; #1 is a loop counter
                      		; #2 is the value of N
  iconst_0        		; #1 <- 0
  istore_1
  
  bipush 81      				; #2 <- 81
  istore_2
    
LoopEntry:
  iload_2          			  	; load 81
  iconst_1       				; compare 81 against 1
  if_icmpeq  LoopExit
                      			 	; branch to LoopExit if equal
; Now begin statements for calculations on even/odd results

; entry point for if/else
  iload_2                   		; load current value (81)
  iconst_2                  		; load number 2 to determine if odd or even
  irem                   			; calculate remainder
  iconst_0                    	; compare remainder against zero
  if_icmpgt CaseOdd   	; goto CaseOdd if it's odd
  
CaseEven:  
; divide local variable #2 by 2 and resave
  iload_2      ; load current value (81)
  iconst_2    ; push 2 onto stack for division
  idiv            ; do the division
  istore_2	; update the "current value"
  
  goto Exit   ; and skip the Caseodd block

CaseOdd:
;multiply local variable #2 by 3 and add one
  iload_2    ; load current value
  iconst_3  ; push 3 onto stack for multiplication
  imul         ; multiply (value is now current value * 3)
  iconst_1  ; push 1 onto stack for addition
  iadd         ; add (value is now current value + 1)
  istore_2   ; store the new value

Exit:
  ; time to increment!
  iinc 1 1                 ; increment loop index
  goto  LoopEntry   ; branch unconditionally to top and recheck

LoopExit:
   ; print the result to System.out
   getstatic java/lang/System/out Ljava/io/PrintStream;
   iload 1               ; load loop counter for printing
   invokevirtual java/io/PrintStream/println(I)V
   return                ; finished
.end method
    