;------------------------------------------------------------------------------
; Displays the message "hello world" without the warning "segmentation fault"
;------------------------------------------------------------------------------

section .data
message: db 'hello, world!', 10

section .text
global _start

_start:
  ; syscall number 'write'
  mov   rax, 1
  ; stdout
  mov   rdi, 1
  ; string address
  mov   rsi, message
  ; string size in bytes
  mov   rdx, 14
  syscall

  ; syscall exit(0)
  mov   rax, 60
  xor   rdi, rdi
  syscall
