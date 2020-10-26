; Стек  программы
AStack SEGMENT STACK
	DW 2 DUP(?)
AStack ENDS

;Данные программы
DATA SEGMENT
a DW 3
b DW 0
i DW 2
k DW 4
i1 DW ?
i2 DW ?
res DW ?
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
	mov ax, DATA
	mov ds, ax

	mov ax, a
	cmp ax, b
	jle f1_down ;jump if a <= b
				;ZF = 1 || SF != OF

f1_up:   ;a > b
	mov ax, i
	shl ax, 1
    neg ax
	mov bx, ax
    add ax, 15
    mov i1, ax

	jmp f2_up

f1_down:  ;a <= b
	mov ax, i
	shl ax, 1
    add ax, i
	mov bx, ax
    add ax, 4
    mov i1, ax

    jmp f2_down

f2_up:   ;a > b
    shl bx, 1
    mov ax, bx
	add ax, 7
    mov i2, ax

    jmp f3_if

f2_down:  ;a <= b
    shl bx, 1
	neg bx
	mov ax, 8
	add ax, bx
    mov i2, ax

    jmp f3_if

f3_if:
    cmp k, 0
    jge f3_down ;jump if k >= 0
				;SF = OF

f3_up:   ;k < 0
    mov ax, 10
    sub ax, i2
    cmp i1, ax
    jg f3_up_i1 ;jump if i1 > 10 - i2
				;ZF = 0 && SF = OF

f3_up_i2:
    mov res, ax
    jmp main_end

f3_up_i1:
    mov ax, i1
    mov res, ax

    jmp main_end

f3_down:  ;k >= 0
    mov ax, i1
    sub ax, i2
    cmp ax, 0
    jl f3_down_abs	;jump if ax < 0
					;SF != OF

    mov res, ax

    jmp main_end

f3_down_abs:
    neg ax
	mov res, ax

    jmp main_end

main_end:
    mov ah, 4ch
    int 21h

Main	ENDP
CODE	ENDS
	END Main
