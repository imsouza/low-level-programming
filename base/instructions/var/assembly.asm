bits 64

global var
section .data
  var: dd 777

section .text

global assembly
assembly:
  add   dword [var], 3
  ret
