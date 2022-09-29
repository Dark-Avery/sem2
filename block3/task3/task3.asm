include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_3 (блок_3) 'Округление' ",0       ; информация о решаемой задаче

.code
    Start:
        mov EDI, ESP
        ConsoleTitle offset T
        outstr 'Введите положительное вещ. число (в конце пробел): '
        mov EAX, 0
        inchar AL
        cmp AL, '0'
        jb err
        cmp AL, '9'
        ja err
        push EAX
        mov EBP, ESP        ;начало целой части
                
L1:     inchar AL
        cmp AL, '.'
        je real
        cmp AL, '0'
        jb err
        cmp AL, '9'
        ja err
        push EAX
        jmp L1
        
real:   inchar AL
        cmp AL, '0'
        jb err
        cmp AL, '9'
        ja err
        push EAX
        mov ESI, ESP        ;начало вещ. части
                
L2:     inchar AL
        cmp AL, ' '
        je chg
        cmp AL, '0'
        jb err
        cmp AL, '9'
        ja err
        push EAX
        jmp L2
        
chg:    inint ECX,'Кол-во знаков после запятой: '
        mov EBX, ESI
        sub EBX, ECX
        sub EBX, ECX
        sub EBX, ECX
        sub EBX, ECX
L3:     cmp ESP, EBX
        jbe @F
        sub ESP, 4
        mov AL, '0'
        mov [ESP], EAX
        jmp L3
@@:     mov EAX, [EBX]
        cmp EAX, '5'
        jb nchg
        mov EDX, EBX
        add EDX, 4
L4:     mov EAX, [EDX]
        cmp AL, '9'              ;!!!!!!!!!!!!!!
        jne not9
        cmp EDX, EBP
        je fir10
        mov AL, '0'
        mov [EDX], EAX
        add EDX, 4
        jmp L4
not9:   mov EAX, [EDX]
        inc EAX
        mov [EDX], EAX
        jmp nchg
        
fir10:  sub EBP, 4
        outchar '1'
        outchar '0'
        cmp EBP, EBX
        je fin
        
nchg:   mov EDX, EBP
L5:     cmp EDX, ESI
        jne ncomma
        outchar '.'
ncomma: mov EAX, [EDX]
        outchar AL
        sub EDX, 4
        cmp EDX, EBX
        je fin
        jmp L5
        
err:    outstr 'Ошибка в записи числа'
        
fin:    newline
        mov ESP, EDI
        pause
        exit
    end Start
