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

    mov ax, a
    mov bx, b
    cmp ax, bx

    jg great_branch ; if ax > bx

less_branch:
    ; f1 (3i + 4) =================
    ; 3*i
    mov dx, i
    ; *2
    shl dx, 1
    ; +i
    add dx, i
    ; +4
    add dx, 4

    mov i1, dx
    ; ====================

    ; f2 (6i - 10) =================
    ; dx = 3i + 4
    shl dx, 1
    ; dx = 6i + 8
    add dx, -18

    mov i2, dx
    ; ====================

    jmp res


great_branch:
    ; f1 (15 - 2i) ===================
    ; 2*i
    mov dx, i
    shl dx, 1
    ; -15
    sub dx, 15
    neg dx

    mov i1, dx
    ; ================================

    ; f2 (-(4i + 3)) =================
    neg dx
    ; dx = -15 + 2i
    shl dx, 1
    ; dx = -30 + 4i
    add dx, 33
    neg dx

    mov i2, dx
    ; ================================

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

; k != 0
res_nonzero:
    ; максимальный в bx
    mov result, bx
    jmp end_prog

; k = 0
res_zero:
    ; минимальный в ax
    mov result, ax
    
end_prog:
    mov ah, 4ch
    int 21h

Main ENDP
CODE ENDS
    END Main