global start
global run

section .bss
  width:  resd 1  ; size_t width
  height: resd 1  ; size_t height
  map:    resq 1  ; cell_t *map

section .text

start:
  mov [width], ecx  ; first argument
  mov [height], edx ; second argument
  mov [map], r8     ; third argument
  ret

run:
  ret
