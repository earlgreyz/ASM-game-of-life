#include <stdio.h>
#include <assert.h>
#include "unit_tests.h"
#include "game_private.h"

#define width 6
#define height 6

static cell_t map[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 1, 1, 1, 1, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 1, 0, 0,
  0, 1, 1, 0, 1, 0,
  0, 0, 0, 0, 0, 0,
};

static size_t neighbours[(width * height)] = {
  0, 0, 0, 0, 0, 0,
  0, 3, 5, 4, 2, 0,
  0, 5, 8, 6, 4, 0,
  0, 5, 7, 5, 3, 0,
  0, 3, 4, 4, 1, 0,
  0, 0, 0, 0, 0, 0,
};

void test_prepare_neighbours_map(void) {
  printf("Testing _prepare_neighbours_map... ");
  start(width, height, map);
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
