; Задание 13: (2, 8, 3)
; f1 (a, b)         = (a > b)?      -(4*i+3)    : 6*i-10
; f2 (a, b)         = (a > b)?      -(6*i+8)    : 9-3*(i-1) = -3*i+12
; f3 (i1, i2, k)    = (k == 0)?     |i1+i2|     : min(i1, i2)

AStack  SEGMENT STACK
    DW  32  DUP(?)
AStack  ENDS

DATA    SEGMENT
    A   DW  1
    B   DW  1
    I   DW  1
    K   DW  1
    I1  DW  ?
    I2  DW  ?
    RES DW  ?
DATA    ENDS

CODE    SEGMENT
    ASSUME  CS:CODE, DS:DATA, SS:AStack

Main    PROC FAR
    mov ax, DATA
    mov ds, ax
; f1 (a, b)         = (a > b)?      -(4*i+3)    : 6*i-10
f1  :
    mov ax, A
    cmp ax, B    ; if
    jle f2_     ; (a <= b): jmp f1_
    mov ax, I   ; ax = i
    shl ax, 1   ; ax *= 2       ax = 2*i
    shl ax, 1   ; ax *= 2       ax = 4*i
    add ax, 3   ; ax += 3       ax = 4*i+3
    neg ax      ; ax = -ax      ax = -(4*i+3)
    mov I1, ax  ; I1 = ax
    jmp f2
f1_ :           ; else
    sub ax, 7   ; ax -= 7       ax = -3*i+5
    shl ax, 1   ; ax *= 2       ax = -6*i+10
    neg ax      ; ax = -ax      ax = 6*i-10
    mov I1, ax  ; I1 = ax
    jmp f3
; f2 (a, b)         = (a > b)?      -(6*i+8)    : -3*i+12
f2  :
    add ax, I   ; ax += i       ax = -3*i-3
    sub ax, 1   ; ax -= 1       ax = -3*i-4
    shl ax, 1   ; ax *= 2       ax = -6*i-8
    mov I2, ax  ; I2 = ax
    jmp f3
f2_ :           ; else
    mov ax, I   ; ax = i
    shl ax, 1   ; ax *= 2       ax = 2*i
    add ax, I   ; ax += i       ax = 3*i
    neg ax      ; ax = -ax      ax = -3*i
    add ax, 12  ; ax += 12      ax = -3i+12
    mov I2, ax  ; I2 = ax
    jmp f1_
; f3 (i1, i2, k)    = (k == 0)?     |i1+i2|     : min(i1, i2)
f3  :
    cmp K, 0
    jne min
    mov ax, I1  ; ax = I1
    add ax, I2  ; ax = I1 + I2
    cmp ax, 0   ; if (ax >= 0)
    jge fin     ; skip
    neg ax      ; else ax = -ax
    jmp fin
min :
    mov ax, I1
    cmp ax, I2
    jle fin
    mov ax, I2
fin :
    mov RES, ax
    mov  ah, 4ch
    int  21h

Main    ENDP
CODE    ENDS
END Main
