bits 64

global var
section .bss
  var: resd 1

section .text

global assembly
assembly:
  add   dword [var], 777
  ret
