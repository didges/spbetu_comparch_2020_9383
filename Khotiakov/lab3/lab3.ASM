; Стек программы
AStack SEGMENT STACK
     DW 2 DUP(?)
AStack ENDS
; Данные программы
DATA SEGMENT
; Директивы описания данных
a DW 2
b DW 1
i DW 2
k DW -1

i1 DW ?
i2 DW ?
res DW ?

DATA ENDS
; Код программы
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
     mov ax, DATA
     mov ds, ax
     mov ax, a
     cmp ax, b
     jle f12 ; if a <= b -> f12

f11: ;if a > b
     mov ax, i
     mov cl, 2
     shl ax, cl; 4*i
     add ax, i; 5*i
     add ax, i; 6*i
     sub ax, 4; 6*i-4
     neg ax; -(6*i - 4)
     mov i1, ax

f21: ; a > b
     mov ax, i
     sub ax, 1; i - 1
     shl ax, 1; 2(i-1)
     mov i2, ax

     jmp f3_cmp


f12: ; a <= b
     mov ax, i
     shl ax, 1; (2*i)
     add ax, i; (3*i)
     add ax, 6; (3*i + 6)
     mov i1, ax

f22:
     mov ax, i
     shl ax, 1;(2*i)
     add ax, i; (3*i)
     neg ax; (-3*i)
     add ax, 2;(-3*i + 2)
     mov i2, ax

     jmp f3_cmp

f3_cmp:
     cmp k, 0
     jge f32; if k >= 0 -> f32

f31: ;if k<0
     mov ax, i1
     cmp ax, 0
     jg f31_abs1 ; if i1 > 0
     neg ax ; |i1|
f31_abs1:
     mov bx, i2
     cmp bx, 0
     jg f31_abs2 ; if i2 > 0
     neg bx ;|i2|
f31_abs2:
     sub ax, bx; |i1| - |i2|
     mov ax, res
	 jmp main_end

f32:
     mov ax, i2
     cmp ax, 0
     jg f32_abs2 ; if i2 > 0
     neg ax ; |i2|
f32_abs2:
     sub ax, 3; i2 - 3
     cmp ax, 4
     jg f32_max_right; if |i2| - 3 > 4
     mov res, 4
     jmp main_end
f32_max_right:
     mov res, ax

main_end:
     mov ah, 4ch
     int 21h

Main      ENDP
CODE      ENDS
          END Main
