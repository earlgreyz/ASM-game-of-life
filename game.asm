global start
global run

;; Functions exported for tests
global _map_get
global _count_neighbours

section .bss
  width:  resd 1  ; size_t width
  height: resd 1  ; size_t height
  map:    resq 1  ; cell_t *map

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
  lea rax, [rdi + 4 * rax]
  ret

;; Counts the number of alive cell neighbours
;; @param x (rdi)
;; @param y (rsi)
;; @returns void
_count_neighbours:
  mov r8d, edi    ; Save original x
  mov r9d, esi    ; Save original y
  call _map_get   ; _map_get(x, y)
  mov r15, rax    ; Save address of map[x][y]
  xor r14d, r14d  ; Set neighbours = 0
  ;; We're not skipping the cell in a loop, so if it's active it would be added
  sub r14d, [r15] ; We need to subtract it's value from the counter

  ;; Start loops
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
  jecxz _count_loop_end
  ;; else increase alive neighbours count
  inc r14d
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
  mov eax, r14d
  ret

run:
  ret
