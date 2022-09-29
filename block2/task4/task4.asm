include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_4 (блок_2) 'Знаковое 10-е число' ",0       ; информация о решаемой задаче
dig db 10 dup (?),0
.code
    Start:

        ConsoleTitle offset T
        inint EAX,'Введите число из диапазона [-2147483648, 4294967295]: '
        cmp EAX, 0
        jge plus
        outchar '-'
        neg EAX
plus:    
        mov ECX, 10
        mov EBX, ECX
        
L:      mov EDX, 0
        div EBX
        add EDX, '0'
        mov dig[ECX-1], DL
        cmp EAX, 0
        loopne L
        
        lea EDI, dig
        add EDI, ECX
        outstr EDI
        
        pause
        exit
    end Start
