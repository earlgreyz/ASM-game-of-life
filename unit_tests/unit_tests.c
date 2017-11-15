#include <string.h>
#include <stdbool.h>
#include "unit_tests.h"

bool shall_test_all = true;

bool shall_test(char *test_name, int argc, char *argv[]) {
  if (shall_test_all) {
    return true;
  }

  for (size_t i = 1; i < argc; i++) {
    if (strcmp(argv[1], test_name) == 0) {
      return true;
    }
  }

  return false;
}

int main(int argc, char *argv[]) {
  if (argc == 1 || strcmp(argv[1], "all") == 0) {
    shall_test_all = true;
  }

  for (size_t i = 0; i < TESTS_COUNT; i++) {
    if (shall_test(test_names[i], argc, argv)) {
      printf("Running `%s`... ", test_names[i]);
      test_functions[i]();
      printf("OK\n");
    }
  }
  return 0;
}
