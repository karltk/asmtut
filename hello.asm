     global  main
        extern  printf
        section .text
main:   mov     rdi, message  ; rdi gets the first argument (a pointer)
        xor     rax, rax      ; printf has a variable number of arguments,
                              ; so rax needs to be set to the number of
                              ; vector registers used...zero in this case
        call  printf
        xor   eax,eax
        ret
message:
        db      'Hello, World', 10, 0
