#include <stdio.h>
#include <assert.h>
#include "game_private.h"

size_t width = 2, height = 2;
cell_t map[16] = {
  0, 0, 0, 0,
  0, 1, 0, 0,
  0, 1, 1, 0,
  0, 0, 0, 0
};

cell_t *map_get(size_t x, size_t y) {
  return map + y * width + x;
}

void test_pointers(void) {
  for (size_t y = 0; y <= height + 1; y++) {
    for (size_t x = 0; x <= width + 1; x++) {
      assert(_map_get(x, y) == map_get(x, y));
    }
  }
}

int main() {
  start(width, height, map);
  test_pointers();
}
