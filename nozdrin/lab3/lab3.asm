; Задание 13: (2, 8, 3)
; f1 (a, b)         = (a > b)?      -(4*i+3)    : 6*i-10
; f2 (a, b)         = (a > b)?      -(6*i+8)    : 9-3*(i-1)
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
    cmp A, B    ; if
    jle f1_     ; (a <= b): jmp f1_
    mov ax, I   ; ax = i
    shl ax, 1   ; ax *= 2       ax = 2*i
    shl ax, 1   ; ax *= 2       ax = 4*i
    add ax, 3   ; ax += 3       ax = 4*i+3
    neg ax      ; ax = -ax      ax = -(4*i+3)
    mov I1, ax  ; I1 = ax
    jmp f2
f1_ :           ; else
    mov ax, I   ; ax = i
    shl ax, 1   ; ax *= 2       ax = 2*i
    mov bs, ax  ; bx = ax       bx = 2*i
    shl ax, 1   ; ax *= 2       ax = 4*i
    add ax, bx  ; ax += bx      ax = 6*i
    sub ax, 10  ; ax -= 10      ax = 6*i-10
    mov I1, ax  ; I1 = ax
    jmp f2
; f2 (a, b)         = (a > b)?      -(6*i+8)    : 9-3*(i-1)
f2  :
    cmp A, B    ; if
    jle f2_     ; (a <= b): jmp f1_
    mov ax, I   ; ax = i
    shl ax, 1   ; ax *= 2       ax = 2*i
    mov bs, ax  ; bx = ax       bx = 2*i
    shl ax, 1   ; ax *= 2       ax = 4*i
    add ax, bx  ; ax += bx      ax = 6*i
    add ax, 8   ; ax += 8       ax = 6*i+8
    neg ax      ; ax = -ax      ax = -(6*i+8)
    mov I2, ax  ; I2 = ax
    jmp end
f2_ :           ; else
    mov ax, I   ; ax = i
    sub ax, 1   ; ax -= 1       ax = i-1
    mov bx, ax  ; bx = ax       bx = i-1
    shl ax, 1   ; ax *= 2       ax = 2*(i-1)
    add ax, bx  ; ax += bx      ax = 3*(i-1)
    mov I2, ax  ; I2 = ax
    jmp end
; f3 (i1, i2, k)    = (k == 0)?     |i1+i2|     : min(i1, i2)
; f3  :
;     mov ax, 0
;     cmp K, ax
;     jg f3_1
;     mov ax, I1
;     mov bx, I2
;     sub ax, bx
;     mov bx, 0
;     cmp bx, ax
;     jg f3_2_neg
;     jmp f3_2_1
; 
; f3_1:
;     mov ax, I2
;     neg ax
;     mov bx, 6
;     neg bx
;     cmp ax, bx
;     jg f3_1_1
;     mov RES, bx
;     jmp f_end 
; 
; f3_1_1:
;     mov RES, ax
;     jmp f_end
; 
; 
; f3_2_neg:
;     neg ax
;     jmp f3_2_1
; 
; f3_2_1:
;     mov bx, 2
;     cmp ax, bx
;     jg f3_2_1_a
;     mov RES, ax
;     jmp f_end
; 
; f3_2_1_a:
;     mov RES, bx
;     jmp f_end
; 
end     :
    mov  ah, 4ch
    int  21h

Main    ENDP
CODE    ENDS
END Main
