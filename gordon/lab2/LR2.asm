; Программа изучения режимов адресации процессора IntelX86
EOL EQU '$'
ind EQU 2
n1 EQU 500 ;01F4h
n2 EQU -50 ;FFCEh
; Стек программы
AStack SEGMENT STACK
DW 12 DUP(?) ;12*2=24b
AStack ENDS
; Данные программы
DATA SEGMENT
; Директивы описания данных
mem1 DW 0
mem2 DW 0
mem3 DW 0
vec1 DB 1,2,3,4,8,7,6,5 ;8b
vec2 DB -10,-20,10,20,-30,-40,30,40 ;8b
matr DB 1,2,3,4,-4,-3,-2,-1,5,6,7,8,-8,-7,-6,-5 ;16b
DATA ENDS
; Код программы
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, SS:AStack
; Головная процедура
Main PROC FAR
push DS
sub AX,AX ;AX = 0
push AX
mov AX,DATA
mov DS,AX
; ПРОВЕРКА РЕЖИМОВ АДРЕСАЦИИ НА УРОВНЕ СМЕЩЕНИЙ
; Регистровая адресация
mov ax,n1 ;в ax 500
mov cx,ax ;в cx 500
mov bl,EOL ;в bl $(BX = 0024)
mov bh,n2 ; в bh -50d(BX = CE24)
; Прямая адресация
mov mem2,n2 ;-50(CEh) в mem2
mov bx,OFFSET vec1 ;bx адрес 0 элемента
mov mem1,ax ;500 в mem1
; Косвенная адресация
mov al,[bx] ;значение, которое содержится по адресу в al(01)
;mov mem3,[bx] ;improrer operand type
; Базированная адресация
;7 ;extra char-s in line (warning)
mov al,[bx]+3
mov cx,3[bx] ;3[bx] == 04 (сверху то же самое)
; Индексная адресация
mov di,ind ;di = 0002
mov al,vec2[di] ;vec2[2] = 10d = Ah
;mov cx,vec2[di] ;operand types must match (warning) 
; Адресация с базированием и индексированием
mov bx,3
mov al,matr[bx][di] ;matr[bx][di] = matr[BX+DI] = matr[3+2] == -3
;mov cx,matr[bx][di] ;operand types must match (warning)
;mov ax,matr[bx*4][di] ;illegal register value
; ПРОВЕРКА РЕЖИМОВ АДРЕСАЦИИ С УЧЕТОМ СЕГМЕНТОВ
; Переопределение сегмента
; ------ вариант 1
mov ax, SEG vec2 ;1A07
mov es, ax
mov ax, es:[bx] ;в es: F401(mem1) CEFFh(mem2) 0000(mem3) 01 и т.д. по смещению 3 у нас получится FF00. в ax запишется 00FF.
mov ax, 0
; ------ вариант 2
mov es, ax
push ds
pop es
mov cx, es:[bx-1] ;F401 CEFF 0000 01..., bx = 2 => FFCE
xchg cx,ax ;AX = FFCE
; ------ вариант 3
mov di,ind ;di = 0002
mov es:[bx+di],ax ;F401 CEFF 0000 01 02 03 04..., bx+di = 3+2 = 5 => F401 CEFF 00CE FF 02 03 04
; ------ вариант 4
mov bp,sp
;mov ax,matr[bp+bx] ;multiple base registers
;mov ax,matr[bp+di+si] ;multiple index registers
; Использование сегмента стека
;push mem1
;push mem2
mov bp,sp
mov dx,[bp]+2 ;в стеке берем +2 элемент...логично
ret 2
Main ENDP ;phase error between passes
CODE ENDS
END Main