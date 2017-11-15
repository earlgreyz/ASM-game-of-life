#ifndef UNIT_TESTS_H
#define UNIT_TESTS_H

#define TESTS_COUNT 5

void test_map_get(void);
void test_count_neighbours(void);
void test_prepare_neighbours_map(void);
void test_apply_neighbours_map(void);
void test_run(void);

char *test_names[TESTS_COUNT] = {
  "map_get",
  "count_neighbours",
  "prepare_neighbours_map",
  "apply_neighbours_map",
  "run",
};

void (*test_functions[TESTS_COUNT])(void) = {
  &test_map_get,
  &test_count_neighbours,
  &test_prepare_neighbours_map,
  &test_apply_neighbours_map,
  &test_run,
};

#endif
