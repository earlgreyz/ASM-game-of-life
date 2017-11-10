#include <stdio.h>
#include <assert.h>
#include "game_private.h"

#define width 4
#define height 4

cell_t map[(width * height)] = {
  0, 0, 0, 0,
  0, 1, 0, 0,
  0, 1, 1, 0,
  0, 0, 0, 0
};

cell_t *map_get(size_t x, size_t y) {
  return map + y * width + x;
}

void test_pointers(void) {
  printf("Testing pointers... ");
  for (size_t y = 0; y < height; y++) {
    for (size_t x = 0; x < width; x++) {
      assert(map_get(x, y) == _map_get(x, y));
    }
  }
  printf("OK.\n");
}

void test_values(void) {
  printf("Testing values... ");
  assert(*map_get(0, 0) == 0);
  assert(*map_get(1, 1) == 1);
  assert(*map_get(2, 1) == 0);
  assert(*map_get(1, 2) == 1);
  printf("OK.\n");
}

int main() {
  start(width, height, map);
  test_pointers();
  test_values();
}
