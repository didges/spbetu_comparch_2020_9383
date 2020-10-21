.186
DOSSEG
  .model small
  .STACK 100h
  .DATA
a dw 0
b dw 0
i dw 0
k dw 0
resf1 dw 0
resf2 dw 0
resf3 dw 0
  .CODE
begin:
      mov ax,@DATA
      mov ds,ax
      mov di,offset a
      mov cx,4                        ;счетчик , 4, т.к. нужно ввести 4 значения
inputNumbers:                         ;ввод значений
      mov dx,0                        ;для знака
      call input                      ;вызов процедуры которая считывает число
      cmp dx,0                        ;сравниваем dx с 0
      je ContinueInputNumbers         ;если равен 0 то переходим на метку
      neg Word Ptr es:[di]            ;делаем отрицательной переменную
ContinueInputNumbers:
      inc di
      inc di
      loop inputNumbers
;Вычисляем первую функцию: 15 - 2*i if a>b  else 3*i+4
      mov ax,a
      cmp ax,b
      mov ax,i                  ;заносим в ax i
      JNG MarkF1                ;a<=b
      shl ax,1                  ;умножаем ax на 2 сдвигом
      mov resf1,15              ;заносим в результат 15
      sub resf1,ax              ;resf1 = 15-2*i
      jmp F2                    ;переходим в вычислению второй функции
  MarkF1:                       ;a<=b
      mov resf1,4               ;заносим в результат 4
      shl ax,1                  ;умножаем ax на 2 сдвигом
      add ax,i                  ;прибавляем к ax i
      add resf1,ax              ;resf1  = 4+3*i
F2:                             ;Вычисляем вторую функцию:-(6*i+8) if a>b else 9-3*(i-1)
      mov ax,a                  ;заносим в ax a
      cmp ax,b                  ;сравниваем а и b
      mov ax,i                  ;заносим в ax значение i
      mov dx,ax                 ;копируем ax в dx
      JNG MarkF2                ;a<=b
      mov resf2,-8              ;заносим в результат -8
      shl dx,1                  ;в dx: i*2
      shl ax,2                  ;в ax: i*4
      add ax,dx                 ;ax = i*4+i*2 =i*6
      sub resf2,ax              ;resf2 = -8 - i*6 = -(6*i+8)
      jmp F3                    ;переходим к вычислению третьей функции
MarkF2:                         ;a<=b
      mov resf2,12              ;заносим в ax 12
      shl ax,1                  ;умножаем ax на 2 сдвигом
      add ax,i                  ;ax = 3*i
      sub resf2,ax              ; resf2=12 - 3*i = 9 - 3*(i-1)
F3:                             ;Вычисляем третью функцию |resf1| + |resf2| if k<0 else max(6,|resf1|)
      mov ax,RESF1              ;заносим в ax resf1
      mov bx,RESF2              ;заносим в bx resf2
      cmp ax,0                  ;сравниваем ax с 0
      jnl MarkF3_1              ;если ax>= 0 то переходим на метку
      neg ax                    ;иначе делаем положительным
MarkF3_1:
      cmp bx,0                  ;сравниваем bx с0
      jnl MarkF3_2              ;если bx>=0 то переходим на метку
      neg bx                    ;иначе делаем положительным
MarkF3_2:
      mov cx,k                  ;заносим в cx значение k
      cmp cx,0                  ;сравниваем с 0
      jl MarkF3_3               ;если k<0 переходим на метку
      cmp ax,6                  ;сравниваем ax с 6
      jl Set_6                  ; если 6 больше то установить значение 6
      mov resf3,ax              ; иначе установить значение |resf1|
      jmp Endprog               ; переходим в конец программы
Set_6:
      mov resf3,6               ; устанавливаем 6
      jmp Endprog               ; переходим в конец программы
MarkF3_3:                       ;если k<0
      add ax,bx                 ;складываем ax и bx
      mov resf3,ax              ;заносим в resf3
Endprog:
      mov ah,4ch
      int 21h
INPUT PROC NEAR                 ;процедура ввода числа
      mov bx,10                 ;для увеличения разряда
      push cx                   ;сохраняем значение cx
Mark1:
      mov ah,1h
      int 21h
      cmp al,2dh                ; сравниваем с кодом минуса
      jne Continue              ; если не минус переходим на метку
      mov dx,1                  ; если dx=1 то число затем будет преобразовано в отрицательное
      jmp Mark1
Continue:
      sub al,30h                ; вычитаем чтобы получить цифру а не код символа
      mov ah,0                  ; расширяем до слова
      mov cx,ax                 ; первая цифра в cx
Mark2:
      mov ah,1h
      int 21h
      cmp al,0dh                ;сравнивем с кодом enter
      je EndInput               ;если enter то заканчиваем ввода числа
      sub al,30h                ;получаем цифру
      mov ah,0h                 ;расширяем до слова
      xchg ax,cx                ;в cx следующее число, в ax предыдущее
      push dx                   ;сохраняем dx в стек
      mul bx                    ;умножаем предыдущее число на 10
      pop dx                    ;вытаскиваем dx
      add cx,ax                 ;cx = ax*10 + cx
      jmp Mark2
EndInput:                       ;конец ввода
      mov ax,seg a              ;кладем в ax начало сегмента с переменными
      mov es, ax                ;переносим его в es
      mov WORD PTR es:[di],cx   ;переносим значение из cx в переменную
      pop cx
      ret
input endp
    end
end begin
