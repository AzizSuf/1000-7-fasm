format PE console
entry main
include 'C:\FASM\INCLUDE\WIN32A.INC'


; ===== Секция данных =====
section '.data' data readable writable
    format_dnum  db '%d - 7 ?', 10, 0
    str_ghoul db "I'm a Ghoul!"


; ===== Секция кода =====
section '.code' code readable executable
main:

    mov esi, 1000
    .loop_start:
        cmp esi, 6
        jle .loop_end 

        push esi
        push format_dnum
        call [printf]
        add esp, 8

        sub esi, 7

        push 30
        call [Sleep]
        jmp .loop_start     
    .loop_end:
        ;mov esi, 1000
        ;jmp .loop_start
        push str_ghoul
        call [printf]
        add esp, 8

    call [getch]
    call exit_program

exit_program:
    push 0
    call [ExitProcess]


; ===== Секция импорта =====
section '.idata' import data readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll'

    import kernel,\
           ExitProcess, 'ExitProcess',\
           Sleep, 'Sleep'
    import msvcrt,\
    printf, 'printf',\
    getch, '_getch',\
    putchar, 'putchar',\
    scanf, 'scanf'
