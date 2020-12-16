bits 64

global assembly
assembly:
  mov   eax, 0

  mov   rbx, 7
  mov   rcx, 2
  cmp   rbx, rcx
  jle   .end
  ; jmp   .end
  mov   eax, 1

 .end
    ret

; In C:
;
; int eax = 0;
; int rbx = 7;
; int rcx = 5;
;
; if (rbx > rcx) {
;   eax = 1;
; }
;
; return;