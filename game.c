#include <stdio.h>
#include <stdlib.h>
#include "game.h"

#define DEAD_CELL  ' '
#define ALIVE_CELL '*'

#define map_get(x, y) (map + width * (y) + (x))

size_t width, height;
cell_t *map;

/**
 * Initializes map with guardians and values from STDIN.
 * @param width desired map width.
 * @param height desired map height.
 **/
void initialize_map(size_t width, size_t height) {
  // Increase width and height by 2 to provide "Guardians"
  width += 2;
  height += 2;
  map = (cell_t *) malloc(sizeof(cell_t) * width * height);

  for (size_t y = 0; y < height; y++) {
    for (size_t x = 0; x < width; x++) {
      // If we're on the first/last row/column set the guardians
      if (x == 0 || x == width - 1 || y == 0 || y == height - 1) {
        *map_get(x, y) = 0;
      } else {
        scanf("%d", map_get(x, y));
      }
    }
  }
}

/**
 * Converts cell value to its char representation.
 * ' ' - dead cell
 * '*' - alive cell
 * @returns cell representation.
 **/
char get_representation(cell_t cell) {
  return (cell & 0x01) == 0? DEAD_CELL: ALIVE_CELL;
}

/**
 * Prints map ASCII representation.
 **/
void print_map(void) {
  for (size_t y = 1; y <= height; y++) {
    for (size_t x = 1; x <= width; x++) {
      printf("%c", get_representation(*map_get(x, y)));
    }
    printf("\n");
  }
}

/**
 * Initialize program.
 **/
void init(void) {
  scanf(" %lu %lu", &width, &height);
  initialize_map(width, height);
  start(width, height, map);
}

/**
 * Free all alocated memory to avoid leaks.
 **/
void cleanup(void) {
  free(map);
}

/**
 * Runs the game.
 **/
void iterate(void) {
  size_t steps;
  do {
    scanf(" %lu", &steps);
    run(steps);
    print_map();
  } while (steps > 0);
}

int main(int argc, char *argv[]) {
  init();
  iterate();
  cleanup();
  return 0;
}
