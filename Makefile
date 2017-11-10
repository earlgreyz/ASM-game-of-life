game: game.c game.o
	gcc -o game -Wall -O2 game.c game.o

.SECONDARY:
%.o: %.asm
	nasm -f elf64 -F dwarf -g $<

clean:
	rm -f *.o game
