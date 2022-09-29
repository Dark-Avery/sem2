include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_6 (блок_1) 'Пятеричное число' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        inchar BL, 'Введите число в пятеричной системе счисления: '
        mov ECX, 0
        mov ESI, 5
        
L:      mov EAX, ECX
        mul ESI
        mov ECX, EAX
        sub BL, '0'
        movzx EBX, BL
        add ECX, EBX
        inchar BL
        cmp BL, ' '
        je fin
        jmp L
        
fin:    outwordln ECX,,'В десятичной: '
        
        pause
        exit
    end Start
