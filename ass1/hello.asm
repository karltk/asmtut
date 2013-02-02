  BITS 64
  GLOBAL main
  EXTERN printf

  SECTION .text

main:
  mov   rdi, message
  xor   rax, rax
  call  printf

  xor   eax,eax
  ret

message:
  db      'Hello, Humla!', 10, 0
