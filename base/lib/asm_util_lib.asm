section .text

exit:
  mov   rax, 60
  xor   rdi, rdi
  syscall


print_newline:
  mov   rdi, 10
  jmp   print_char


print_string:
  push  rdi
  call  string_length
  pop   rsi
  mov   rdx, rax 
  mov   rax, 1
  mov   rdi, 1 
  syscall
  ret


print_char:
  push  rdi
  mov   rdi, rsp
  call  print_string 
  pop   rdi
  ret


print_uint:
  mov   rax, rdi
  mov   rdi, rsp
  push  0
  sub   rsp, 16
  
  dec   rdi
  mov   r8, 10

 .loop:
    xor   rdx, rdx
    div   r8
    or    dl, 0x30
    dec   rdi 
    mov   [rdi], dl
    test  rax, rax
    jnz   .loop 
   
    call  print_string
    
    add   rsp, 24
 .end:
    ret


print_int:
  test  rdi, rdi
  jns   print_uint
  push  rdi
  mov   rdi, '-'
  call  print_char
  pop   rdi
  neg   rdi
  jmp   print_uint


print_hax:
  mov   rax, 0x4A

  mov   rdi, 1
  mov   rdx, 1
  mov   rcx, 64

 .loop:
    push  rax
    sub   rcx, 4
    sar   rax, cl
    and   rax, 0xf
    lea   rsi, [codes + rax]
    mov   rax, 1

    push  rcx
    syscall
    pop   rcx

    pop   rax
    test  rcx, rcx
    jnz   .loop
 .end:
    ret


read_char:
  push 0
  xor   rax, rax
  xor   rdi, rdi
  mov   rsi, rsp 
  mov   rdx, 1
  syscall
  pop   rax
  ret


read_word:
  push  r14
  push  r15
  xor   r14, r14 
  mov   r15, rsi
  dec   r15

 .A:
    push  rdi
    call  read_char
    pop   rdi
    cmp   al, ' '
    je    .A
    cmp   al, 10
    je    .A
    cmp   al, 13
    je    .A 
    cmp   al, 9 
    je    .A
    test  al, al
    jz    .C

 .B:
    mov   byte [rdi + r14], al
    inc   r14

    push  rdi
    call  read_char
    pop   rdi
    cmp   al, ' '
    je    .C
    cmp   al, 10
    je    .C
    cmp   al, 13
    je    .C 
    cmp   al, 9
    je    .C
    test  al, al
    jz    .C
    cmp   r14, r15
    je    .D

    jmp   .B

 .C:
    mov   byte [rdi + r14], 0
    mov   rax, rdi 
   
    mov   rdx, r14 
    pop   r15
    pop   r14
    ret

 .D:
    xor   rax, rax
    pop   r15
    pop   r14
    ret


parse_uint:
  mov   r8, 10
  xor   rax, rax
  xor   rcx, rcx
 .loop:
    movzx r9, byte [rdi + rcx] 
    cmp   r9b, '0'
    jb    .end
    cmp   r9b, '9'
    ja    .end
    xor   rdx, rdx 
    mul   r8
    and   r9b, 0x0f
    add   rax, r9
    inc   rcx 
    jmp   .loop 
 .end:
    mov   rdx, rcx
    ret


parse_int:
  mov   al, byte [rdi]
  cmp   al, '-'
  je    .signed
  jmp   parse_uint

 .signed:
    inc   rdi
    call  parse_uint
    neg   rax
    test  rdx, rdx
    jz    .error
    inc   rdx
    ret

 .error:
    xor   rax, rax
    ret


string_equals:
  mov   al, byte [rdi]
  cmp   al, byte [rsi]
  jne   .no
  inc   rdi
  inc   rsi
  test  al, al
  jnz   string_equals
  mov   rax, 1
  ret
  .no:
    xor   rax, rax
    ret


string_copy:
  push  rdi
  push  rsi
  push  rdx
  call  string_length
  pop   rdx
  pop   rsi
  pop   rdi

  cmp   rax, rdx
  jae   .too_long
  
  push rsi 

 .loop: 
    mov   dl, byte[rdi]
    mov   byte[rsi], dl
    inc   rdi
    inc   rsi
    test  dl, dl
    jnz   .loop 
    pop   rax
 .end: 
    ret

 .too_long:
    xor   rax, rax
    ret


string_length:
  xor   rax, rax
 .loop
    cmp   byte [rdi+rax]
    je    .end
    inc   rax
    jmp   .loop
 .end:
    ret
