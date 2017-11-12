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

cell_t applied_map[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 1, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 1, 0,
  0, 1, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0,
};

void set_neighbours(size_t x, size_t y) {
  cell_t *cell_ptr = map_get(map, x, y);
  cell_t cell_state = *cell_ptr;
  size_t neighbours_count = *map_get(neighbours, x, y);
  *cell_ptr = (neighbours_count << 8) + cell_state;
}

int main() {
  start(width, height, map);
  for (size_t y = 1; y < height - 1; y++) {
    for (size_t x = 1; x < width - 1; x++) {
      set_neighbours(x, y);
    }
  }

  printf("Testing _apply_neighbours_map... ");
  _apply_neighbours_map();
  for (size_t y = 1; y < height - 1; y++) {
    for (size_t x = 1; x < width - 1; x++) {
      assert(*map_get(map, x, y) == *map_get(applied_map, x, y));
    }
  }
  printf("OK.\n");
}
