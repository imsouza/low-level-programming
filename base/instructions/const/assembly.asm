bits 64

section .data
  CONST: equ 5

section .text

global assembly
assembly:
  mov   eax, CONST + 1
  ret
