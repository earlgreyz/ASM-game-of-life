test_map_get: test_map_get.c game.o
	gcc -o test_map_get -O0 test_map_get.c game.o

.SECONDARY:
game.o: ../game.asm
	nasm -f elf64 ../game.asm -o game.o

clean:
	rm -f *.o test_map_get
