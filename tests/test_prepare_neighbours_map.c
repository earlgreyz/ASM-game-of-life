#include <stdio.h>
#include <assert.h>
#include "game_private.h"

#define width 6
#define height 6

#define map_get(map, x, y) (map + width * (y) + (x))

cell_t map[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 1, 1, 1, 1, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 0, 1, 0,
  0, 0, 0, 0, 0, 0,
};

size_t neighbours[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 3, 5, 4, 2, 0,
  0, 5, 8, 6, 4, 0,
  0, 5, 7, 5, 3, 0,
  0, 3, 4, 4, 1, 0,
  0, 0, 0, 0, 0, 0,
};

int main() {
  start(width, height, map);
  printf("Testing _prepare_neighbours_map... ");
  _prepare_neighbours_map();
  for (size_t y = 1; y < height - 1; y++) {
    for (size_t x = 1; x < width - 1; x++) {
      cell_t * cell = map_get(map, x, y);
      size_t neighbours_count = (*cell) >> 8;
      assert(neighbours_count == *map_get(neighbours, x, y));
    }
  }
  printf("OK.\n");
}
