; 3.7.5 => tab 2 = f3 and f7 and f5(tab3)
Astack SEGMENT STACK
  DW 32 DUP(?)
AStack ENDS

DATA SEGMENT
a         DW 1
b         DW 2
i         DW 3
k         DW 0
i1        DW ?
i2        DW ?
result    DW ?
DATA ENDS

CODE SEGMENT
  ASSUME CS:CODE, DS:DATA, SS:AStack

Main PROC FAR
  mov ax, DATA
  mov ds, ax


Func3_i1_1:
  mov ax, a     ; ax = 1
  cmp ax, b     ; b = 2 => a <= b
  jg Func3_i1_2    ; переходим к функции "7 - 4*i" если a>b

  ; 8 - 6*i выполняем
  mov ax, i
  shl ax, 1     ; ax = 2*ax
  mov bx, ax    ; bx = ax           ; при этих данных -10 тут
  shl ax, 1     ; ax = 4*ax
  add ax, bx    ; ax = 2*ax + 4*ax = 6*ax
  neg ax        ; ax = -6*ax
  add ax, 8     ; ax = 8 - 6*ax
  mov i1, ax

  jmp Func7_i2_1


; 7 - 4i
Func3_i1_2:
  mov ax, i
  shl ax, 1      ; ax = 2ax
  shl ax, 1      ; ax = 4ax
  neg ax         ; ax = -4ax
  add ax, 7
  mov i1, ax
  jmp Func7_i2_2


; if a<=b: 10-3*i   (нужно сделать из 8 - 6*i)
Func7_i2_1:       ; взаимосвязь с Func3_i1_1
  mov cx, i
  mov dx, cx      ; dx = cx
  shl cx, 1       ; cx = 2cx          ; тут будет значение 1 при этом i

  add cx, dx      ; cx = cx + 2cx = 3cx
  neg cx          ; cx = -3cx
  add cx, 10      ; 10 - 3cx
  mov i2, cx
  ;готово
  jmp f5_sum



; if a>b: -(4*i - 5) = 5 - 4i   (нужно сделать из 7 - 4*i)
; тут сделать только сложение
Func7_i2_2:
  mov ax, i     ; ax = i
  shl ax, 1     ; ax = 2i
  shl ax, 1     ; ax = 4i
  sub ax, 5     ; ax = 4i - 5
  neg ax        ; 5 - 4i
  mov i2, ax
;  jmp f5_sum


f5_sum:
  mov ax, k
  cmp k, 0
  je f5_min      ; jump if equal
  jmp f5_res_SumAbs_1

  ;jl f5_res_SumAbs     ; если не равно то прыгаем на f5_res_SumAbs

f5_min:
  mov bx, i1
  mov cx, 6
  cmp bx, 0 ; if i1<0 -> neg i1
  jl f5_neg
  jmp f5_cmp_main



f5_neg:
  mov bx, i1
  neg bx  ; bx = -i1
  jmp f5_cmp_main

f5_cmp_main:
  mov cx, 6
  cmp bx, cx    ; bx v cx
  jl f5_res_i1
  jmp f5_res_6


f5_res_SumAbs_1:
  mov bx, i1 ; тут все верно
  cmp bx, 0
  jl f5_neg_sum
  jmp f5_res_SumAbs_2

f5_res_SumAbs_2:
  mov cx, i2
  cmp cx, 0
  jl f5_neg_sum_2
  jmp f5_res_SumAbs_continue

f5_neg_sum:
  neg bx
  jmp f5_res_SumAbs_2
                          ; эти две ф-ии для работы в случе k != 0
f5_neg_sum_2:
  neg cx
  jmp f5_res_SumAbs_continue

f5_res_SumAbs_continue:
  mov ax, bx
  add ax, cx
  mov result, ax
  jmp f_end


f5_res_6:
  mov result, 6
  jmp f_end


f5_res_i1:
  mov result, bx
  jmp f_end


f_end:
  mov ah, 4ch
  int 21h


Main  ENDP
CODE  ENDS
      END Main
