  BITS 64
  GLOBAL main
  EXTERN printf

  SECTION .text

main:
  mov   rdi, message                ; this is a comment
  xor   rax, rax
  call  printf

  xor   rax,rax
  ret

message:
  db      'Hello, Humla!', 10, 0
