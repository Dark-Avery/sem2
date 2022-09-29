include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_10 (блок_4) 'Формула' ",0
ans db 'Да',0,'Нет',0
.code
    Form proc
        push EBX
        push ECX
        push EDX
        
        inchar CL
        cmp CL, '0'
        jb @F
        cmp CL, '9'
        ja @F
        sub CL, '0'
        movzx EAX, CL
        jmp @fin
        
@@:     call Form
        mov EBX, EAX
        inchar CL
        call Form
        xchg EBX, EAX
        
        cmp CL, '+'
        jne @F
        add EAX, EBX
        inchar CL
        jmp @fin
@@:     cmp CL, '-'
        jne @F
        sub EAX, EBX
        inchar CL
        jmp @fin
@@:     xor EDX, EDX
        mul EBX
        inchar CL
        
@fin:   pop EDX
        pop ECX
        pop EBX
        ret
    Form endp
    
    Start:
        ConsoleTitle offset T
        outstr 'Введите текст вида <формула> = <формула>: '
        call Form
        mov EBX, EAX
        inchar CL        
        inchar CL        
        inchar CL 
        call Form
        lea ESI, ans
        cmp EAX, EBX
        je @F
        lea ESI, ans+3
@@:     outstrln ESI
        pause
        exit
    end Start
