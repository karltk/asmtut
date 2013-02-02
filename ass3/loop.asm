  BITS 64
  GLOBAL main
  EXTERN printf

%define NUMBER 1337

  SECTION .data
message  db  '%d', 10, 0

  SECTION .text

main:
  push  rbp
  mov   rbp, rsp
  push  rbx
  sub   rsp, 8

  mov   rbx, 0
.loop:
  mov   rdi, rbx
  call  printnum
  add   rbx, 222
  cmp   rbx, NUMBER
  jl    .loop

  add   rsp, 8
  pop   rbx
  mov   rsp, rbp
  pop   rbp
  xor   eax, eax
  ret

printnum:
  push  rbp
  mov   rbp, rsp
  mov   rsi, rdi
  mov   rdi, message
  xor   rax, rax
  call  printf
  mov   rsp, rbp
  pop   rbp
  ret
