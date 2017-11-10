global start
global run

;; Functions exported for tests
global _map_get

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
;; @param x (ecx)
;; @param y (edx)
;; @returns void
_count_neighbours:
  mov r8d, ecx   ; Save original x
  mov r9d, edx   ; Save original y
  call _map_get  ; _map_get(x, y)
  mov r15d, rax  ; Save address of map[x][y]

  xor r14d, r14d ; Set neighbours = 0
  mov r11d, -1   ; Initialize y_counter
_loop_y:
  mov r10d, -1   ; Initialize x_counter
_loop_x:
  ;; cell_ptr = _map_get(x + x_couter, y + y_counter)
  mov ecx, r8d
  add ecx, r10d
  mov edx, r9d
  add edx, r11d
  call _map_get
  ;; if (*cell_ptr == 0) end loop
  mov ecx, [rax]
  jecxz _loop_end
  ;; else increase alive neighbours count
  inc r14d
_loop_end:
  ;; Check x loop
  inc r10d
  cmp r10d, 1
  jle _loop_x
  ;; Check y loop
  inc r11d
  cmp r11d, 1
  jle _loop_y
  ;; Return
  mov eax, r14d
  ret

run:
  ret
