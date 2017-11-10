#include <stdio.h>
#include <assert.h>
#include "game_private.h"

#define width 6
#define height 6

cell_t map[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 1, 1, 1, 1, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 0, 1, 0,
  0, 0, 0, 0, 0, 0,
};

int main() {
  start(width, height, map);
  printf("Testing _count_neighbours... ");
  assert(_count_neighbours(2, 2) == 8);
  assert(_count_neighbours(2, 3) == 7);
  assert(_count_neighbours(3, 2) == 6);
  assert(_count_neighbours(1, 2) == 5);
  assert(_count_neighbours(2, 4) == 4);
  assert(_count_neighbours(4, 3) == 3);
  assert(_count_neighbours(4, 4) == 1);
  printf("OK.\n");
}
