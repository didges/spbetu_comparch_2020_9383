AStack SEGMENT STACK
	DW 32 DUP(?)   			
AStack ENDS
				
DATA SEGMENT				
	A 	DW 4
	B 	DW 2
	I 	DW 1
	K 	DW 0
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
	mov ax, A
	mov bx, B
	cmp ax, bx
	jg f1_1
	jmp f1_2

f1_1:
	mov ax, I
	shl ax, 1
	shl ax, 1
	mov bx, 7
	sub bx, ax
	mov I1, bx
	jmp f2

f1_2:
	mov ax, I
	mov bx, I
	shl ax, 1
	shl ax, 1
	shl ax, 1
	shl bx, 1
	sub ax, bx
	mov bx, 8
	sub bx, ax
	mov I1, bx
	jmp f2

f2:
	mov ax, A
	mov bx, B
	cmp ax, bx
	jg f2_1
	jmp f2_2

f2_1:
	mov ax, I
	shl ax, 1
	mov bx, 2
	sub ax, bx
	mov I2, ax
	jmp f3

f2_2:
	mov ax, I
	mov bx, I
	shl bx, 1
	shl bx, 1
	sub ax, bx
	mov bx, 2
	add ax, bx
	mov I2, ax
	jmp f3

f3:
	mov bx, K
	cmp bx, 0
	je f3_1
	jmp f3_2


f3_1:
	mov ax, I1
	mov bx, I2
	add ax, bx
	cmp ax, 0
	jg f3_neg
	mov RES, ax
	jmp f_end

f3_neg:
	neg ax
	jmp f3_1

f3_2:
	mov ax, I1
	mov bx, I2
	cmp ax, bx
	jb f_3_2_1
	mov RES, bx
	jmp f_end

f_3_2_1:
	mov RES, ax
	jmp f_end
		
f_end:
	mov  ah, 4ch		
	int  21h  


 
Main      ENDP
CODE      ENDS
END Main
	

	
	
	
		