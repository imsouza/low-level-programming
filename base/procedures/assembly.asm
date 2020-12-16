bits 64

global assembly
assembly:
  mov   eax, 3
  call func
  ret

  func:
    mov   eax, 5
    ret