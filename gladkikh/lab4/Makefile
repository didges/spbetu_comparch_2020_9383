ASM_FLAGS = -masm=intel -m64

all: lab4
	@echo Done! To start a program write ./lab4

lab4: source.o
	@g++ source.o -o lab4

source.o: source.cpp
	@g++ -c source.cpp $(ASM_FLAGS)

clear:
	@rm -r *.o
	@rm lab4
