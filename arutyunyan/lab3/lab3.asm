; Стек программы
AStack SEGMENT STACK
    DW 12 DUP(?)
AStack ENDS

; Данные программы
DATA SEGMENT
a DW 1
b DW 2
i DW 3
k DW 4
i1 DW ?
i2 DW ?
result DW ?
DATA ENDS


; Код программы
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:AStack

; Головная процедура
Main PROC FAR
    mov ax, DATA
    mov ds, ax

f1:
    mov ax, a
    mov bx, b
    cmp ax, bx

    jg f1_great ; if ax > bx
    jmp f1_less

; 15 - 2*i
f1_great:
    ; 2*i
    mov dx, i
    shl dx, 1
    ; -15
    sub dx, 15
    neg dx

    mov i1, dx
    jmp f2

; 3i + 4
f1_less:
    ; 3*i
    mov dx, i
    ; *2
    shl dx, 1
    ; +i
    add dx, i
    ; +4
    add dx, 4

    mov i1, dx


f2:
    mov ax, a
    mov bx, b
    cmp ax, bx

    jg f2_great
    jmp f2_less

; -(4i + 3)
f2_great:
    mov dx, i
    ; *4
    mov cl, 2
    shl dx, cl
    ; +3
    add dx, 3
    neg dx

    mov i2, dx
    jmp res

; 6i - 10
f2_less:
    mov dx, i
    ; *4
    mov cl, 2
    shl dx, cl
    ; +i
    add dx, i
    ; +i
    add dx, i
    ; -10
    sub dx, 10

    mov i2, dx


; f3
res:
    mov ax, i1
    mov bx, i2
    mov cx, k

    ; упорядочиваем ax и bx
    cmp ax, bx
    jg min
    jmp res2

min:
    xchg ax, bx

res2:
    cmp k, 0
    jz res_zero
    jmp res_nonzero


; k = 0
res_zero:
    ; минимальный в ax
    mov result, ax
    jmp end_prog

; k != 0
res_nonzero:
    ; максимальный в bx
    mov result, bx
    
end_prog:
    mov ah, 4ch
    int 21h

Main ENDP
CODE ENDS
    END Main