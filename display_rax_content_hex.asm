;------------------------------------------------------------------------------
; Displays rax content in hexadecimal format
;------------------------------------------------------------------------------

section .data
codes:
  db    '0123456789ABCDEF'

section .text
global _start

_start:
  ; Number in hexadecimal format
  mov   rax, 0x4A

  mov   rdi, 1
  mov   rdx, 1
  mov   rcx, 64

  .loop:
    push  rax
    ; Each 4 bits must be displayed in hexadecimal
    sub   rcx, 4
    ; SHR moves all bits of the binary number 1 or more positions to the right, 
    ; so essentially diving by 2. SAR does the same but for signed numbers. 
    ; It essentially keeps the sign bit of the number (that shows if the number is positive or negative) 
    ; unaffected.
    sar   rax, cl
    and   rax, 0xf

    ; Calculates the memory cell address and stores it in rsi
    lea   rsi, [codes + rax]
    mov   rax, 1

    push  rcx
    syscall
    pop   rcx

    pop   rax
    ; Creates an AND of the rcx value with itself and checks if the value is zero
    test  rcx, rcx
    jnz   .loop

    ; syscall exit(0)
    mov   rax, 60
    xor   rdi, rdi
    syscall