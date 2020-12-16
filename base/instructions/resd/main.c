#include <stdio.h>

int assembly (void);
extern int var;

int main (void) {
  assembly();
  printf("Value: %i\n", var);
  return 0;
}
