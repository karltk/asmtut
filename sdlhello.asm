  GLOBAL  main
  EXTERN  SDL_Init, SDL_Quit, SDL_SetVideoMode, SDL_PollEvent, SDL_LockSurface, SDL_UnlockSurface, SDL_Flip

%define SDL_SWSURFACE  0x00000000
%define SDL_HWSURFACE  0x00000001
%define SDL_FULLSCREEN 0x80000000

%define SDL_INIT_VIDEO 0x00000020

%define SDL_KEYDOWN   2
%define SDL_QUIT      12

%define WIDTH   640
%define HEIGHT  480
%define BPP     32

%define pitch   24
%define pixels  32

  SECTION .data
screen: dq 0
event:  times 128 db 0

  SECTION .text

main:
  push  rbp
  mov   rbp, rsp

  mov   rdi, draw_stuff
  call  run_the_show

  mov   rsp, rbp
  pop   rbp

  xor   rax, rax
  ret

draw_stuff:
  push  rbp
  mov   rbp, rsp
  mov   r8, rsi
  mov   rsi, rdi

  mov   rax, WIDTH-1
  mov   rdx, HEIGHT-1
.inner:
  lea   rdi, [rsi + rax*4]
  mov   [rdi], edi ;DWORD 0xFFFFFFFF
  dec   rax
  jnz   .inner
  mov   rax, WIDTH-1
  add   rsi, r8
  dec   rdx
  jnz   .inner

  mov   rsp, rbp
  pop   rbp
  ret

;
; ====================================================================================
;

run_the_show:
  push  rbp
  mov   rbp, rsp
  push  rdi
  push  rdi

  mov   rdi, SDL_INIT_VIDEO
  call  SDL_Init

  mov   rdi, WIDTH
  mov   rsi, HEIGHT
  mov   rdx, BPP
  mov   rcx, SDL_SWSURFACE
  call  SDL_SetVideoMode
  mov   [screen], rax

  pop   rdi
  pop   rdi
  call  poll_for_keypress

  call  SDL_Quit

  mov   rsp, rbp
  pop   rbp

  xor   rax,rax
  ret


prepare_draw_stuff:
  push  rbp
  mov   rbp, rsp
  push  rdi
  push  rdi

  mov   rdi, [screen]
  call  SDL_LockSurface

  mov   rdi, [screen]
  movzx rsi, WORD [rdi + pitch]
  mov   rdi, [rdi + pixels]
  pop   rax
  pop   rax
  call  rax

  mov   rdi, [screen]
  call  SDL_UnlockSurface

  mov   rdi, [screen]
  call  SDL_Flip

  mov   rsp, rbp
  pop   rbp
  ret

poll_for_keypress:
  push  rbp
  mov   rbp, rsp
  push  rbx
  push  rbx
  mov   rbx, rdi

.loop:
  mov   rdi, rbx
  call  prepare_draw_stuff

  mov   rdi, event
  call  SDL_PollEvent
  mov   rdi, event
  cmp   [rdi], BYTE SDL_KEYDOWN
  je    .exit
  cmp   [rdi], BYTE SDL_QUIT
  je    .exit
  jmp   .loop

.exit:
  pop   rbx
  pop   rbx
  mov   rsp, rbp
  pop   rbp
  ret
