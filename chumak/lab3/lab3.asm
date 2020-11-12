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
i2_2:
	mov ax, a
	cmp ax, b
	jg i2_1	;если a > b, то переходим к i2_1
			;иначе a <= b, выполняем действия дальше
	mov ax, i	;ax = i
	mov bx, ax	;bx = i, ax = i
	shl ax, 1	;ax = 2*i
	add ax, bx	;ax = 3*i
	neg ax		;ax = (-3)*i
	add ax, 2	;ax = (-3)*i+2, что идентично ax = 2-3*i
	mov i2, ax
i1_2:
	shl ax, 1	;ax = 4-6*i
	add ax, 2	;ax = 6-6*i, что идентично ax = -(6*i-6)
	mov i1, ax
	jmp i3
i2_1:
	mov ax, i
	shl ax, 1	;ax = 2*i
	sub ax, 2	;ax = 2*i-2
	mov i2, ax
i1_1:
	shl ax, 1	;ax = 4*i-4
	neg ax		;ax = 4-4*i
	add ax, 16	;ax = 20-4*i
	mov i1, ax
i3:
	mov ax, k
	cmp k, 0
	jl i3_1	;если k < 0, то переходим к i3_1
			;иначе k >= 0, выполняем действия дальше
	mov ax, i2	;ax = i2
	neg ax		;ax = -i2
	cmp ax, -6
	jg i3_res	;если ax > -6, то переходим к выводу -i2
	mov res, -6	;иначе res = -6
	jmp f_end
i3_1:
	mov ax, i1	;ax = i1
	sub ax, i2	;ax = i1-i2
	cmp ax, 0	
	jg i3_cmp_2	;если ax > 0, то переходим к сравнению с 2
			;иначе берём модуль
	neg ax		;ax = -i1+i2
i3_cmp_2:
	cmp ax, 2
	jl i3_res	;если ax < 2, то переходим к выводу ax
	mov res, 2
	jmp f_end	
i3_res:
	mov res, ax
f_end:
	mov ah, 4ch
	int 21h
Main	ENDP
CODE	ENDS
	END Main
