all: test_map_get test_count_neighbours test_prepare_neighbours_map test_apply_neighbours_map

test_map_get: test_map_get.c game.o
	gcc -o test_map_get -O0 test_map_get.c game.o

test_count_neighbours: test_count_neighbours.c game.o
	gcc -o test_count_neighbours -O0 test_count_neighbours.c game.o

test_prepare_neighbours_map: test_prepare_neighbours_map.c game.o
	gcc -o test_prepare_neighbours_map -O0 test_prepare_neighbours_map.c game.o

test_apply_neighbours_map: test_apply_neighbours_map.c game.o
	gcc -o test_apply_neighbours_map -O0 test_apply_neighbours_map.c game.o

.SECONDARY:
game.o: ../game.asm
	nasm -f elf64 ../game.asm -o game.o

clean:
	rm -f *.o test_map_get test_count_neighbours test_prepare_neighbours_map test_apply_neighbours_map
