DATA SEGMENT
res     DW      ?
a       DW      1
b       DW      2
i       DW      4
k       DW      -1
i1      DW      ?
i2      DW      ?
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
        cmp ax, b ;Сравнение а и б
        jle f1_second ;a <= b
        mov ax, i ;
        shl ax, 1 ;
        neg ax ;
        add ax, 15 ; Помещаем в ax 15-2i
        mov i1, ax ; Помещаем в i1 значение из ax

        jmp f2
f1_second: ;jump сюда если а <= b
        mov ax, i ;
        shl ax, 1 ;
        add ax, i ;
        add ax, 4 ;Помещаем в ax 3i+4
        mov i1, ax ;Помещаем в i1 значение из ax

f2_second:;если a <= b
        mov ax, i;
        shl ax, 1;
        add ax, i;
        shl ax, 1;
        neg ax;
        add ax, 6; Помещаем в ax -6i+6
        mov i2, ax ;Помещаем в i2 значение из ax

        jmp fk_4
f2:; jump сюда если a > b
        mov ax, i;
        shl ax, 1;
        shl ax, 1;
        neg ax;
        add ax, 20;Помещаем в ax 20-4i
        mov i2, ax ;Помещаем в i2 значение из ax
fk_4:
        mov ax, k
        cmp ax, 0
        jge fk4_second ;k >= 0
        mov ax, i1;
        sub ax, i2;Помещаем в ax i1-i2
        cmp ax, 0;Сравниваем i1-i2 и 0
        jl f_neg ;i1-i2 < 0
        jmp fk_4_first_final

f_neg:;если i1-i2 < 0 и нужен модуль
        neg ax;Переводим в отрицательное(нужен модуль)
        jmp fk_4_first_final

fk4_second:;если k>=0
        mov ax, i2;
        neg ax;Помещаем в ax -i2
        cmp ax, -6;Сравниваем ax и -6
        jl fmax ; -i2 < -6
        mov res, ax ;Помещаем ax в результат
        jmp f_end
fmax:;Если -i2 < -6
        mov res, -6 ;Помещаем -6 в результат
        jmp f_end

fk_4_first_final:
        cmp ax, 2;Сравниваем ax и 2
        jg fmin ;|i1-i2| > 2
        mov res, ax; Помещаем в res ax
        jmp f_end
fmin:; если |i1-i2| > 2
        mov res, 2;Помещаем 2 в результат
        jmp f_end
f_end:
        mov ah, 4ch
        int 21h
Main	ENDP
CODE	ENDS
        END Main
