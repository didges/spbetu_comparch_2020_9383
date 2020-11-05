DATA SEGMENT
a       DW      1
b       DW      0
i       DW      2
k       DW      0
i1      DW      ?
i2      DW      ?
res     DW		?
DATA ENDS

AStack SEGMENT STACK
    DW 16 DUP(?)
AStack ENDS

CODE SEGMENT
    ASSUME CS:CODE, SS:AStack, DS:DATA
Main PROC FAR
    mov ax, DATA
    mov ds, ax
	
f1:
    mov ax, a
    cmp ax, b ;Сравнение a и b
    jle f1_second ;a <= b
	
    mov ax, i ;
	shl ax, 1 ;   ;2i
	add ax, i ;   ;3i
	shl ax, 1 ;   ;6i
    ;shl ax, 1 ; ;2i
	;mov bx, ax ; ;2i
	;shl ax, 1 ;  ;4i
	;add ax, bx ; ;4i+2i=6i
	sub ax, 4 ;  ;6i-4
	neg ax ;     ;-(6i-4)
	mov i1, ax ;
	
    jmp f2
	
f1_second: ;jump сюда если а <= b
    mov ax, i ;
	add ax, 2 ;
	mov bx, ax ;   ;bx=i+2
	shl ax, 1 ;    ;2*(i+2)
	add ax, bx ;   ;3*(i+2)
    mov i1, ax ;   ;Помещаем в i1 значение из ax

f2_second:         ;если a <= b
    mov ax, i;
	sub ax, 1;
	mov bx, ax ;   ;bx=i-1
	shl ax, 1 ;    ;2*(i-1)
	add ax, bx ;   ;3*(i-1)
	neg ax ;       ;-3*(i-1)
	add ax, 9 ;    ;9-3*(i-1)
    mov i2, ax ;   ;Помещаем в i2 значение из ax

    jmp f3
	
f2:                ;jump сюда если a > b
    mov ax, i;
	shl ax, 1 ;   ;2i
	add ax, i ;   ;3i
	shl ax, 1 ;   ;6i
	add ax, 8 ;   ;6i+8
	neg ax ;      ;-(6i+8)
    mov i2, ax ;Помещаем в i2 значение из ax
	
	
f3:
    mov ax, k
    cmp ax, 0
	je f3_first ;k = 0
	
	mov ax, i1 ; 
	mov bx, i2 ;
	cmp ax, bx ;
	jge min_i2 ;   ;i1 >=i2
	mov res, ax ;
	
	jmp f_end
	
min_i2:
	mov res, bx ;
	jmp f_end


f3_first:
	mov ax, i1 ;
	add ax, i2 ;
	cmp ax, 0 ;
	jle abs_neg ;   ;i1+i2 <= 0
	mov res, ax ;
	
	jmp f_end

abs_neg:
	neg ax ;
	mov res, ax ;


f_end:
        mov ah, 4ch
        int 21h
Main	ENDP
CODE	ENDS
        END Main