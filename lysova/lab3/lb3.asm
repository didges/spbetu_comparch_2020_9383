AStack SEGMENT STACK
	DW 32 DUP(?)
AStack ENDS

DATA SEGMENT
a	DW	2
b	DW	1
i	DW	3
k	DW	-3
i1	DW	?
i2	DW	?
res	DW	?
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
	mov ax, DATA
	mov ds, ax

f1:
	mov ax, a
	cmp ax, b
	jg f1_1		;if a>b
			;a<=b
	mov ax, i
	shl ax, 1	;ax = 2*ax
	mov bx, ax	;bx = 2*ax
	shl ax, 1	;ax = 4*ax
	add ax, bx	;ax = 6*ax
	sub ax, 10	;ax = ax - 10
	mov i1, ax
	
	jmp f2
f1_1:
	mov ax, i
	shl ax, 1
	shl ax, 1
	add ax, 3
	neg ax	
	mov i1, ax

f2:
	mov ax, a
	cmp ax, b
	jg f2_1		;if a>b
			;a<=b
	mov ax, i
	shl ax, 1	;ax = 2*ax
	mov bx, ax	;bx = 2*ax
	shl ax, 1	;ax = 4*ax
	add ax, bx	;ax = 6*ax
	sub ax, 6	;ax = ax - 6
	neg ax		;ax = -ax
	
	mov i2, ax
	jmp f3

f2_1:
	mov ax, i
	shl ax, 1	;ax = 2*ax
	mov bx, ax	;bx = 2*ax
	shl ax, 1	;ax = 4*ax
	neg ax		;ax = -ax
	add ax, 20	;ax = ax + 20

	mov i2, ax
	
f3:
	mov ax, k
	cmp k, 0
	jl f3_1		;if k < 0
	
	mov ax, i2
	cmp ax, 0	;if ax < 0
	jl f_abs	;then |ax|
	
	jmp f3_cmp_7

f3_1:
	mov ax, i1	;ax = i1
	sub ax, i2	;ax = i1 - i2
	cmp ax, 0	;if ax < 0
	jl f_abs_1	;then ax = |ax|

	jmp f3_res
f_abs:
	neg ax		;ax = -ax

f3_cmp_7:
	cmp ax, 7	;if ax < 7
	jl f3_7		;res = 7

	jmp f3_res

f3_res:
	mov res, ax	;else res = ax

	jmp f_end
	
f_abs_1:
	neg ax		;ax = |ax|

	jmp f3_res

f3_7:
	mov res, 7	;res = 7
	jmp f_end	

f_end:
	mov ah, 4ch
	int 21h
	
Main	ENDP
CODE	ENDS
	END Main
