# Low Level Programming

This repository contains C and Assembly code implementations based on my low-level programming studies

## Compile pure asm

```
$ nasm -felf64 file.asm -o file.o
$ ld -o file file.o
$ chmod u+x file
$ ./file
```

## Compile and link with C file

```
$ nasm file.asm -f elf64
$ gcc -c main.c -o main.o
$ gcc file.o main.o -o test -no-pie
$ ./test
```

## Makefile

```
all:
  nasm *.asm -felf64
  gcc -c *.c
  gcc -no-pie *.o -o test
```

## OS Support

Unix/Linux

## Author

Mateus Almeida

## License

This project is licensed under the [MIT](https://github.com/imsouza/low-level-programming/blob/main/LICENSE) License.
