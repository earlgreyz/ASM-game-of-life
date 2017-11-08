maximum: game.c game.o
	gcc -o game -Wall -O2 game.c game.o

.SECONDARY:
%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

%: %.o
	ld $< -o $@ -lc --dynamic-linker=/lib64/ld-linux-x86-64.so.2

clean:
	rm -f *.o game
