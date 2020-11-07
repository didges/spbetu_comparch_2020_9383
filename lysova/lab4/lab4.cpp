#include <iostream>
#include <string>
#include <fstream>
	
int N = 81;

void printHello(){
	std::cout << "______________________________________________________________________________________\n";
    std::cout << "|                                                                                    |\n";
    std::cout << "|Работа Лысовой Александры                                                           |\n";
    std::cout << "|10. Преобразование введенных во входной строке шестнадцатиричных цифр в двоичную СС,|\n";
	std::cout << "| остальные символы входной строки передаются в выходную строку непосредственно.     |\n";
    std::cout << "|____________________________________________________________________________________|\n";
}

int main(){
	std::ofstream output;
	output.open("./output.txt");
	printHello();

	char* source = new char[N];
	std::cout << "Input string:\n";
	std::cin.getline(source, N);
	char* target = new char[4*N];// = func(source);

	asm(
		".intel_syntax noprefix\n\t"

		" mov rsi, %0\n\t" //rsi = *target
		" mov rdi, %1\n\t"	//rdi = *source

		"input:\n\t"
		" mov ah, [rdi]\n\t"
		" inc rdi\n\t"
		" mov bh, 0x8\n\t"
		" mov ecx, 4\n\t"
		" cmp ah, 0\n\t"
		" je end\n\t"

		" cmp ah, 0x30\n\t"
		" jl check\n\t"
		" cmp ah, 0x39\n\t"	
		" jle digit\n\t"	
		" cmp ah, 'A'\n\t"
		" jl check\n\t"
		" cmp ah, 'F'\n\t"
		" jle letter\n\t"
		" jmp check\n\t"

		"digit:\n\t"
		" sub ah, 0x30\n\t"
		" jmp bin8\n\t"

		"letter:\n\t"
		" sub ah, 0x37\n\t"
		" jmp bin8\n\t"

		"bin8:\n\t"
		" cmp ah, bh\n\t"
		" jl print0\n\t"
		" mov al, '1'\n\t"
		" mov [rsi], al\n\t"
		" inc rsi\n\t"
		" sub ah, bh\n\t"
		" shr bh\n\t"
		" loop bin8\n\t"
		" jmp input\n\t"

		"print0:\n\t"
		" mov al, '0'\n\t"
		" mov [rsi], al\n\t"
		" inc rsi\n\t"
		" shr bh\n\t"
		" loop bin8\n\t"
		" jmp input\n\t"

		"check:\n\t"
		" mov [rsi], ah\n\t"
		" inc rsi\n\t"
		" jmp input\n\t" 
		"end:\n\t"
		
		: "=m" (target)
		: "m" (source)
	);
	
	std::cout << "Output string:\n" << target << '\n';
	output << "Output string:\n" << target << '\n';

	output.close();
	delete[] source;
	delete[] target;
	return 0;
}
