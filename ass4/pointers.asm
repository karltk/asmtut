  BITS 64
  GLOBAL main
  EXTERN puts, printf

%define NUMBER 1337

  SECTION .data
message  db "V zhfg fnl, penpxvat vf zhpu yvxr nphchapgher. Vg'f nobhg svaqvat gur evtug fcbgf gb vafreg fbzr ABCf.", 10, 0

printnum_message db '%d', 10, 0

  SECTION .text

main:
  push  rbp
  mov   rbp, rsp
  push  rbx
  sub   rsp, 8

  mov   rbx, message
.loop:
  mov   al, [rbx]
  cmp   al, 0
  je   .exit

  cmp   al, 'a'
  jae   .small_z

  cmp   al, 'A'
  jae   .big_z
  jmp   .next

.big_z:
  mov   ah, 'Z' - 'A' + 1
  mov   dl, 'Z'
  cmp   al, 'Z'
  jbe   .bitflip
  jmp   .next

.small_z:
  mov   ah, 'z' - 'a' + 1
  mov   dl, 'z'
  cmp   al, 'z'
  jbe   .bitflip
  jmp   .next

.bitflip:
  add   al, 0dh
  cmp   al, dl
  jbe   .next
  sub   al, ah
  jmp   .next

.next:
  mov   [rbx], al
  inc   rbx
  jmp   .loop

.exit:

  mov   rdi, message
  call  puts

  add   rsp, 8
  pop   rbx
  mov   rsp, rbp
  pop   rbp
  xor   eax, eax
  ret

printnum:
  push  rbp
  push  rax
  push  rbx
  push  rcx
  push  rdx
  push  rsi
  push  rdi

  mov   rsi, rdi
  mov   rdi, printnum_message
  xor   rax, rax
  call  printf

  pop   rdi
  pop   rsi
  pop   rdx
  pop   rcx
  pop   rbx
  pop   rax
  pop   rbp
  ret
