global start
global run

;; Functions exported for tests
global _map_get
global _count_neighbours
global _prepare_neighbours_map

CELL_SIZE  equ 4    ; Number of bytes in one cell_t
STATE_MASK equ 0x01 ; Bitmask to get cell state

;; Extracts cell state from the cell.
;; @param destination: register
;; @param cell_value
%macro cell_state 2
  mov %1, %2
  and %1, STATE_MASK
%endmacro

;; Create cell.
;; @param destination/neighbours
;; @param state
%macro make_cell 2
  shl %1, 8
  add %1, %2
%endmacro

;; Checks loop condition.
;; @param counter: register
;; @param value: value to check condition on
;; @param label: label begining of the loop
%macro check_loop 3
  dec %1
  cmp %1, %2
  jge %3
%endmacro

;; Wraps function _map_get
%macro map_get 2
  mov edi, %1
  mov esi, %2
  call _map_get
%endmacro

;; Wraps function _count_neighbours
%macro count_neighbours 2
  mov edi, %1
  mov esi, %2
  call _count_neighbours
%endmacro

section .bss
  width:  resd 1    ; size_t width
  height: resd 1    ; size_t height
  map:    resq 1    ; cell_t *map

section .text

start:
  mov [width], edi  ; first argument
  mov [height], esi ; second argument
  mov [map], rdx    ; third argument
  ret

;; Gets the pointer to the requested map cell.
;; @param x (rdi)
;; @param y (rsi)
;; @returns pointer to map[x][y] in RAX
_map_get:
  ;; offset = width * y + x
  mov eax, [width] ; offset = width
  mul rsi          ; offset *= y
  add rax, rdi     ; offset += x
  ;; cell_ptr = map + 4 * offset
  mov rdi, [map]
  lea rax, [rdi + CELL_SIZE * rax]
  ret

;; Counts the number of alive cell neighbours
;; @param x (rdi)
;; @param y (rsi)
;; @returns void
_count_neighbours:
  mov r8d, edi    ; Save original x
  mov r9d, esi    ; Save original y
  xor ecx, ecx    ; Set neighbours_count = 0
  call _map_get   ; current_cell = _map_get(x, y)
  cell_state edx, [rax]
  sub ecx, edx    ; neighbours_count -= state(*current_cell)
  ;; Loops
  mov r11d, 1     ; y_counter = 1
_count_loop_y:
  mov r10d, 1     ; x_counter = 1
_count_loop_x:
  ;; cell_ptr = _map_get(x + x_couter, y + y_counter)
  mov edi, r8d
  add edi, r10d
  mov esi, r9d
  add esi, r11d
  call _map_get
  ;; neighbours_count += state(*cell_ptr)
  cell_state edx, [rax]
  add ecx, edx
_count_loop_end:
  check_loop r10d, -1, _count_loop_x
  check_loop r11d, -1, _count_loop_y
_count_neighbours_end:
  mov eax, ecx
  ret

;; Calculate neighbours count for all cells on the map
_prepare_neighbours_map:
  ;; Save the callee save registers
  push r13
  push r12
  ;; Prepare neighbours map
  mov r13d, [height]    ; Initialize y
  dec r13d              ; y = height - 1
_prepare_loop_y:
  mov r12d, [width]     ; Initialize x
  dec r12d              ; x = width - 1
_prepare_loop_x:
  ;; neighbours_count = _count_neighbours(x, y)
  count_neighbours r12d, r13d
  mov ecx, eax
  map_get r12d, r13d     ; cell_ptr = map_get(x, y)
  cell_state edx, [rax]  ; state = cell_state(*cell_ptr)
  make_cell ecx, edx     ; new_cell = make_cell(neighbours_count, state)
  mov [rax], ecx         ; *cell_ptr = new_cell
_prepare_loop_end:
  check_loop r12d, 1, _prepare_loop_x
  check_loop r13d, 1, _prepare_loop_y
  ;; Restore callee save registers
  pop r12
  pop r13
  ret

run:
  call _prepare_neighbours_map
  ret
