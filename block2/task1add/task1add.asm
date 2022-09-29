include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_1 доп (блок_2) 'Большие числа-1' ",0       ; информация о решаемой задаче
D   dq 1,502,40034,1234567,12345678,123456789,12345678910,1234567891011,123456789101112,0FFFFFFFFFFFFFFFFh

.code
    outqword macro X:req, txt:=<>
    local N, Buf, Ans
        ifnb <txt>
            outstr txt
        endif
        if type X EQ 8
            .data
            N equ 20
            Buf dq ?
            Ans db N dup(?),0
            .code
            push EAX
            push EDX
            push EDI
            push ESI
            mov EAX, dword ptr X
            mov dword ptr Buf, EAX
            mov EAX, 1
            mov EAX, dword ptr X +4
            mov dword ptr Buf + 4, EAX
            lea EDI, Ans + N
            mov ESI, 10         
@@:         xor EDX, EDX
            mov EAX, dword ptr Buf + 4
            div ESI
            mov dword ptr Buf + 4, EAX
            mov EAX, dword ptr Buf
            div ESI
            mov dword ptr Buf, EAX
            add DL, '0'
            dec EDI
            mov byte ptr[EDI], DL
            cmp EAX, 0
            jne @B
            
            outstr EDI
            pop ESI
            pop EDI
            pop EDX
            pop EAX
        endif
    endm
    
    outqwordln macro X:req, txt:=<>
        outqword X, txt
        newline
    endm
    
    Start:
        ConsoleTitle offset T
        mov ECX, 10
        xor EAX, EAX
L:      outword D[EAX*8]
        outqwordln D[EAX*8],' = '
        inc EAX
        dec ECX
        jnz L
        pause
        exit
    end Start
