#include <stdio.h>
#include <stdint.h>

union reg {
  uint32_t eax;

  struct {
    uint8_t al;
    uint8_t ah;
  } ax;
};


int main (void) {
  union reg x = { .eax = 0x11223344 };

  printf("AH :    %02x\n"
         "AL :    %02x\n"
         "AX :    %04x\n"
         "EAX:    %08x\n",
         x.ax.ah,
         x.ax.al,
         x.ax,
         x.eax);

  return 0;
}