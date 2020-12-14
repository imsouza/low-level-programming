;------------------------------------------------------------------------------
; Displays the message "hello world"
;------------------------------------------------------------------------------

global _start

section .data
; db: Create data bytes
message: db 'hello, world', 10

section .text
_start
  ; System call number must be stored in rax
  mov   rax, 1
  ; Arg #1 rdi: where to write
  mov   rdi, 1
  ; Arg #2 rsi: where the string starts
  mov   rsi, message
  ; Arg #3 rdx: number of bytes that must be written
  mov   rdx, 14
  ; Make the system call
  syscall
