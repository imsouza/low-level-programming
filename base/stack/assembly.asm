bits 64

global assembly
assembly:
  mov   rax, 123
  push  rax

  mov   rax, 1122
  pop   rax
  ret