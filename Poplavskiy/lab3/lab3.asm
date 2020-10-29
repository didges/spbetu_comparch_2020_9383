AStack SEGMENT STACK
	DW 32 DUP(?)   			
AStack ENDS
				
DATA SEGMENT				
	A 	DW 5
	B 	DW 1
	I 	DW 3
	K 	DW -5
	I1 	DW ?
	I2 	DW ?
	RES DW ?
DATA ENDS

CODE      SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
	mov  ax, DATA
   	mov  ds, ax
f1:
	cmp A, B
	jg f1_1
	mov bx, I
	mov ax, I
	shl bx, 1
	shl bx, 1
	shl bx, 1
	shl ax, 1
	sub bx, ax
	mov ax, 8
	sub ax, bx
	mov I1, ax
	jmp f2

f1_1:
	mov bx, I
	shl bx, 1
	shl bx, 1
	mov ax, 7
	sub ax, bx
	mov I1, ax
	jmp f2

f2:
	cmp A, B
	jg f2_1
	shr ax, 1
	sub ax, 2	
	mov I2, ax
	jmp f3

f2_1:
	mov ax, I
	shl ax, 1
	mov bx, 2
	sub ax, bx
	mov I2, ax
	jmp f3

f3:
	cmp K, 0
	jg f3_1
	mov ax, I1
	mov bx, I2
	sub ax, bx
	mov bx, 0
	cmp bx, ax
	jg f3_2_neg
	jmp f3_2_1

f3_1:
	mov ax, I2
	neg ax
	mov bx, 6
	neg bx
	cmp ax, bx
	jg f3_1_1
	mov RES, bx
	jmp f_end 

f3_1_1:
	mov RES, ax
	jmp f_end


f3_2_neg:
	neg ax
	jmp f3_2_1

f3_2_1:
	mov bx, 2
	cmp ax, bx
	jg f3_2_1_a
	mov RES, ax
	jmp f_end

f3_2_1_a:
	mov RES, bx
	jmp f_end

f_end:
	mov  ah, 4ch		
	int  21h  


 
Main      ENDP
CODE      ENDS
END Main
