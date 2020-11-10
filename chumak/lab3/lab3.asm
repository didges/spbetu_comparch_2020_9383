AStack SEGMENT STACK
	DW 32 DUP(?)
AStack ENDS

DATA SEGMENT
a	DW	2
b	DW	1
i	DW	2
k	DW	1
i1	DW	?
i2	DW	?
res	DW	?
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
	mov ax, DATA
	mov ds, ax
f1_1:
	mov ax, a
	cmp ax, b
	jg f1_2	;если a > b, то переходим к f1_2
			;иначе a <= b, выполняем действия дальше
	mov ax, i
	shl ax, 1	;ax = 2*i
	mov bx, ax	;bx = 2*i
	shl ax, 1	;ax = 4*i
	add ax, bx	;ax = 6*i
	sub ax, 6	;ax = 6*i-6
	neg ax		;ax = -(6*i-6)
	mov i1, ax
	jmp f2_1
f1_2:
	mov ax, i
	shl ax, 1	;ax = 2*i
	shl ax, 1	;ax = 4*i
	neg ax		;ax = -4*i
	add ax, 20	;ax = -4*i+20, что идентично 20-4*i
	mov i1, ax
f2_1:
	mov ax, a
	cmp ax, b
	jg f2_2	;если a > b, то переходим к f2_2
			;иначе a <= b, выполняем действия дальше
	mov ax, i
	mov bx, ax
	shl ax, 1	;ax = 2*i
	add ax, bx	;ax = 3*i
	neg ax		;ax = -(3*i)
	add ax, 2	;ax = -(3*i)+2, что идентично 2-3*i
	mov i2, ax
	jmp f3
f2_2:
	mov ax, i
	shl ax, 1	;ax = 2*i
	sub ax, 2	;ax = 2*i-2
	mov i2, ax
f3:
	mov ax, k
	cmp k, 0
	jl f3_1	;если k < 0, то переходим к f3_1
			;иначе k >= 0, выполняем действия дальше
	mov ax, i2	;ax = i2
	neg ax		;ax = -i2
	cmp ax, -6
	jg f3_res	;если ax > -6, то переходим к выводу -i2
	mov res, -6	;иначе res = -6
	jmp f_end
f3_1:
	mov ax, i1	;ax = i1
	sub ax, i2	;ax = i1-i2
	cmp ax, 0	
	jg f3_cmp_2	;если ax > 0, то переходим к сравнению с 2
			;иначе идём берём модуль
	neg ax		;ax = -i1+i2
f3_cmp_2:
	cmp ax, 2
	jl f3_res	;если ax < 2, то переходим к выводу ax
	mov res, 2
	jmp f_end	
f3_res:
	mov res, ax
	jmp f_end
f_end:
	mov ah, 4ch
	int 21h
Main	ENDP
CODE	ENDS
	END Main
