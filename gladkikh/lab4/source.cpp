//compile with -masm=intel -m64

#include <iostream>
#include <fstream>

#define STR_SIZE 81

using namespace std;

char* strFunc(char* inp)
{
    int N = STR_SIZE + 1;
    char* out = new char[STR_SIZE + 1];
    asm(
        "mov r8, %0\n" //записываем в регистр адрес начала выходной строки
        "mov rdi, %1\n" //записываем в регистр адрес начала входной строки

        "for_char:\n"
        "mov al, [rdi]\n" //берем текущий символ
        "inc rdi\n" //сдвигаемся к следующему символу
        "cmp al, 0\n" //
        "je break\n"  //если это конец строки, то заканчиваем

        "cmp al, 0x30\n"
        "jl for_char\n"
        "cmp al, 0x7A\n"
        "jg for_char\n"
        "cmp al, 0x39\n"
        "jle writeChar\n"
        "cmp al, 0x41\n"
        "jl for_char\n"
        "cmp al, 0x5A\n"
        "jle writeChar\n"
        "cmp al, 0x61\n"
        "jl for_char\n"

        "writeChar:\n"
        "mov [r8], al\n" //записываем в выходную строку символ
        "inc r8\n"
        "jmp for_char\n"
        "break:\n"

        :"=m"(out)
        :"m"(inp)
	);

    return out;
}

int main(){
    std::cout << "_____________________________________________________________________________\n";
    std::cout << "|                                                                           |\n";
    std::cout << "|Автор: Гладких Андрей, вариант 2                                           |\n";
    std::cout << "|Формирование выходной строки только из цифр и латинских букв входной строки|\n";
    std::cout << "|___________________________________________________________________________|\n";

    int n = STR_SIZE;
    char str[n];
    fgets(str, n, stdin);


    char* str2 = strFunc(str);



    ofstream file("out.txt");
    file << str2 << '\n';
    std::cout << str2 << '\n';
    delete str2;
    return 0;
}
