#include "iostream"
#include <stdio.h>
#include <fstream>
#define N 80

using namespace std;

void initialization()
{
	cout << ".....................................................\n";
	cout << ". Вид преобразования: Преобразование всех заглавных .\n"
		<< ". латинских букв входной строки в строчные, а       .\n"
		<< ". восьмеричных цифр в инверсные, остальные          .\n"
		<< ". символы входной строки передаются в               .\n"
		<< ". выходную строку непосредственно.                  .\n";
	cout << ". Разработал Камзолов Никита, студент группы 9383   .\n";
	cout << ".....................................................\n";
}


int main()
{
	setlocale(0, "");
	initialization();
	char str[N+1];
	cout << "Введите строку\n";
	char c;
	cin.getline(str, N);
	char str_out[N * 2 + 1];
	_asm {
		sub eax, eax; eax = 0
		sub esi, esi; esi = 0
		lea edi, str; edi указывает на начало str
		mov ecx, 80; счетчик - 80
		f1:
		mov al, [edi]; считывает текущий символ str по индуксу edi в al
			cmp al, 'Z'; если больше чем Z, то просто пихаем символ в выходную строку
			jg writeOut
			cmp al, 'A'; если меньше чем A, то идем проверять на восьмеричное число
			jl octalCheck
			add al, 0x20; переводим в нижний регистр
			jmp writeOut
		OctalCheck:
			cmp al, 0x30; если меньше чем 0, то просто пихаем символ в выходную строку
			jl writeOut
			cmp al, 0x37; если больше чем 7, то просто пихаем символ в выходную строку
			jg writeOut
			sub al, 0x30; вычитаем 30, чтобы получить число
			xor al, 0x7; инвертируем 3 бита
			add al, 0x30; добавляем 30, чтобы получить символ
		writeOut:
			mov str_out[esi], al; помещаем текущий символ в выходную строку
			cmp al, 0; если нулевой символ, то заканчиваем выполнять код Ассемблера
			je f_end
			inc edi; увеличиваем индексы
			inc esi
			jmp f1; возвращаемся к началу
		f_end:	
	}
	cout << str_out;
	ofstream file;
	file.open("out.txt");
	file << str_out;
	file.close();
	return 0;
}

