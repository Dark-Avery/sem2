include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_4 (блок_5) 'МНОЖЕСТВА' ",0
L   equ 5
R   equ 155
S   db (R-L)/8+1 dup(0)
ans db 'не входит',0
.code
    Plus proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        
        mov EDX, [EBP+8]
        inint EBX
        sub EBX, L
        mov CL, BL
        and CL, 111b
        shr EBX, 3
        mov AL, 80h
        shr AL, CL
        or [EDX+EBX], AL
        
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4
    Plus endp
    
    Minus proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        
        mov EDX, [EBP+8]
        inint EBX
        
        sub EBX, L
        mov CL, BL
        and CL, 111b
        shr EBX, 3
        mov AL, 7Fh
        ror AL, CL
        and [EDX+EBX], AL
        
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4
    Minus endp
    
    Incl proc
        push EBP
        mov EBP, ESP
        push EBX
        push ECX
        push EDX
        
        mov EDI, [EBP+8]
        mov EBX, [EBP+12]
        
        xor EAX, EAX
        sub EBX, L
        mov CL, BL
        and CL, 111b
        shr EBX, 3
        mov DL, 80h
        ror DL, CL
        test [EDI+EBX], DL
        jz @F
        inc EAX
        
@@:     pop EDX
        pop ECX
        pop EBX
        pop EBP
        ret 4*2
    Incl endp
    
    HM proc
        push EBP
        mov EBP, ESP
        push ECX
        push EDX
        push ESI
        
        mov EDX, [EBP+8]
        
        xor ESI, ESI
        mov ECX, L
@L:     push ECX
        push EDX
        call Incl
        add ESI, EAX
        inc ECX
        cmp ECX, R
        jbe @L
        mov EAX, ESI
        
        pop ESI
        pop EDX
        pop ECX
        pop EBP
        ret 4
    HM endp
    
    Outp proc
        push EBP
        mov EBP, ESP
        push EAX
        push ECX
        push EDX
        
        mov EDX, [EBP+8]
        
        mov ECX, L
@L:     push ECX
        push EDX
        call Incl
        test EAX, 1
        jz @F
        outword ECX
        outchar ' '
@@:     inc ECX
        cmp ECX, R
        jbe @L
        newline
        
        pop EDX
        pop ECX
        pop EAX
        pop EBP
        ret 4
    Outp endp
        
    Start:
        ConsoleTitle offset T
L1:     inchar BL,'Введите команду: '

        cmp BL, '+'
        jne @F
        push offset S
        call Plus
        flush
        jmp L1
        
@@:     cmp BL, '-'
        jne @F
        push offset S
        call Minus
        flush
        jmp L1
        
@@:     cmp BL, '?'
        jne next1
        inint EBX
        push EBX
        push offset S
        call Incl
        lea ESI, ans
        test AL, 1
        jz @F
        lea ESI, ans+3
@@:     outstrln ESI
        flush
        jmp L1
        
next1:  cmp BL, '='
        jne next2
        push offset S
        call HM
        outwordln EAX
        flush
        jmp L1
        
next2:  cmp BL, ':'
        jne @F
        push offset S
        call Outp
        flush
        jmp L1
        
@@:     cmp BL, '.'
        flush
        jne L1
        
        pause 'Нажмите любую клавишу...'
        exit
    end Start
