include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_2 (выход 1)",0       ; информация о решаемой задаче
Y   dd ?
S   db 'Високосный',0,'Не високосный',0
.code
    Start:

        ConsoleTitle offset T
        lea ESI, S+11
        inint Y,'Введите год '
        mov EAX, Y
        mov EDX, 0
        mov EBX, 4
        div EBX
        cmp EDX, 0
        jne outp
        mov EAX, Y
        mov EDX, 0
        mov EBX, 100
        div EBX
        cmp EDX, 0
        jne fin
        mov EAX, Y
        mov EDX, 0
        mov EBX, 400
        div EBX
        cmp EDX, 0
        jne outp
        jmp fin
        
fin:    lea ESI, S
        
outp:   outstr ESI
        
        pause
        exit
    end Start
