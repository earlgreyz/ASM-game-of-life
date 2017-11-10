#ifndef GAME_PRIVATE_H
#define GAME_PRIVATE_H

#include "../game.h"

/// Exported only for tests.
extern cell_t *_map_get(size_t x, size_t y);

/// Exported only for tests.
extern size_t _count_neighbours(size_t x, size_t y);

#endif
