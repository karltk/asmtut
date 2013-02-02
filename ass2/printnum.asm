  BITS 64
  GLOBAL main
  EXTERN printf

%define NUMBER 1337

  SECTION .data
message  db  '%d', 10, 0

  SECTION .text

main:
  call  printnum
  xor   eax, eax
  ret

printnum:
  mov   rdi, message
  mov   rsi, NUMBER
  xor   rax, rax
  call  printf
  ret
