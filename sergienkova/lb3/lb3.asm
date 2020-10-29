AStack SEGMENT STACK
        DW 32 DUP(?)
AStack ENDS

DATA SEGMENT
a	DW	1
b	DW	2
i	DW	3
k	DW	4
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
  cmp ax, b ; a<=b
  jg f1_1	  ; if a>b

  mov ax, i
  mov bx, ax
  shl ax, 1
  add ax, bx ; 3*ax
  add ax, 6 ; 3ax + 6?
  mov i1, ax

jmp f2_1

f1_1:
  mov ax, i
  shl ax, 1
  mov bx, ax	;bx = 2*ax
  shl ax, 1 ; ax = 4*ax
  add ax, bx ; ax = 6*ax
  sub ax, 4	;ax = 6*ax - 4
  neg ax
  mov i1, ax

f2:
  mov ax, i
  shl ax, 1	;ax = 2*ax
  shl ax, 1	;ax = 4*ax
  neg ax
  add ax, 20
  mov i2, ax
  jmp f3 ;8

f2_1:
  mov ax, i
  shl ax, 1 ; ax = 2*ax
  mov bx, ax
  shl ax, 1
  add ax, bx ; ax = 6*ax
  sub ax, 6
  neg ax
  mov i2, ax ;-6

f3:
	mov ax, k
	cmp k, 0
	jl f3_1

  mov ax, i1
  cmp ax, 0	;if ax < 0
  jl f_abs
  jmp f3_cmp_6


f3_1:
  mov bx, i1
  cmp bx, 0  ;if i1 < 0
  jl f_abs_1	;then i1 = |i1|
  jmp f3_2


f_abs:
  neg ax		;ax = -ax
  jmp f3_res


f_abs_1:
  neg bx		;i1 = |i1|
  jmp f3_2

f3_2:
  mov cx, i2
  cmp cx, 0
  jl f_abs_2
  jmp f_sum

f_abs_2:
  neg cx ;i2 = |i2|
  jmp f_sum

f_sum:
  mov ax, bx	;ax = i1
  add ax, cx	;ax = i1 + i2
  jmp f3_res

f3_cmp_6:
  cmp ax, 6	;if ax < 6
  jl f3_6		;res = 6


f3_res:
  mov res, ax	;else res = ax
  jmp f_end


f3_6:
  mov res, 6	;res = 6

f_end:
  mov ah, 4ch
  int 21h

Main	ENDP
CODE	ENDS
END Main
