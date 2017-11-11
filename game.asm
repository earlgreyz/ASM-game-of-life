global start
global run

;; Functions exported for tests
global _map_get
global _count_neighbours
global _prepare_neighbours_map

CELL_SIZE  equ 4    ; Number of bytes in one cell_t
STATE_MASK equ 0x01 ; Bitmask to get cell state

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
  xor ebx, ebx    ; Set neighbours_count = 0
  mov r8d, edi    ; Save original x
  mov r9d, esi    ; Save original y
  call _map_get   ; _map_get(x, y)
  ;; We're not skipping the (x, y) cell in a loop
  sub ebx, [rax] ; We need to subtract it's value from the counter
  ;; Start the loops
  mov r11d, -1    ; Initialize y_counter
_count_loop_y:
  mov r10d, -1    ; Initialize x_counter
_count_loop_x:
  ;; cell_ptr = _map_get(x + x_couter, y + y_counter)
  mov edi, r8d
  add edi, r10d
  mov esi, r9d
  add esi, r11d
  call _map_get
  ;; if (*cell_ptr == 0) end loop
  mov ecx, [rax]
  and ecx, STATE_MASK
  jecxz _count_loop_end
  ;; else increase alive neighbours count
  inc rbx
_count_loop_end:
  ;; Check x loop
  inc r10d
  cmp r10d, 1
  jle _count_loop_x
  ;; Check y loop
  inc r11d
  cmp r11d, 1
  jle _count_loop_y
  ;; Return
_count_neighbours_end:
  mov eax, ebx
  ret

;; Calculate neighbours count for all cells on the map
_prepare_neighbours_map:
  mov r13d, [height]    ; Initialize y
  dec r13d              ; y = height - 1
_prepare_loop_y:
  mov r12d, [width]     ; Initialize x
  dec r12d              ; x = width - 1
_prepare_loop_x:
  ;; neighbours_count = _count_neighbours(x, y)
  mov edi, r12d
  mov esi, r13d
  call _count_neighbours
  ;; Last byte is reserved for cell state
  mov ebx, eax
  shl ebx, 8            ; neighbours_count << 8
  ;; cell_ptr = _map_get(x, y)
  mov edi, r12d
  mov esi, r13d
  call _map_get
  ;; state = (*cell_ptr) | 0x01
  mov edi, [rax]
  and edi, STATE_MASK
  add ebx, edi          ; new_cell.state = cell.state
  mov [rax], ebx        ; *cell_ptr = new_cell
_prepare_loop_end:
  dec r12d              ; x--
  cmp r12d, 1           ; if (x >= 1) loop_x
  jge _prepare_loop_x
  dec r13d              ; y--
  cmp r13d, 1           ; if (y >= 1) loop_y
  jge _prepare_loop_y
  ret

run:
  call _prepare_neighbours_map
  ret
