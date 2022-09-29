include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_4 (блок_4) 'Системы счисления' ",0

.code
    Outd1 proc
        push EAX
        push EBX
        push ECX
        push EDX
        
        movzx EBX, BL
        xor ECX, ECX
@L1:    xor EDX, EDX
        div EBX
        push EDX
        inc ECX
        cmp EAX, 0
        jne @L1
        
@L2:    pop EDX
        outword EDX
        dec ECX
        jnz @L2
        
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        ret
    Outd1 endp
    
    Outd2 proc
        push EAX
        push EBX
        push EDX
        
        movzx EBX, BL
        cmp EAX, EBX
        jb @F
        xor EDX,EDX
        div EBX
        call Outd2
        mov EAX, EDX
@@:     outword EAX
        
        pop EDX
        pop EBX
        pop EAX
        ret
    Outd2 endp
        
    Start:
        ConsoleTitle offset T
        
        inint EAX,'Введите число в 10-ой системе счисления: '
        inint BL,'Введите новое основание системы счисления(2-10): '
        outstr 'Нерекурсивный ответ - '
        call Outd1
        newline
        outstr 'Рекурсивный ответ - '
        call Outd2
        newline
        
        pause
        exit
    end Start
