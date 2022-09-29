include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_7 (блок_1) 'Ближайшее число, кратное семи' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        inint ECX,'Введите число: '
        mov EDX, 0
        mov EAX, ECX
        mov ESI, 7
        
        div ESI
        sub ECX, EDX
        cmp EDX, 3
        ja great
        jmp fin
        
great:  add ECX, 7

fin:    outwordln ECX,,'Ближайшее кратное 7: '
        
        pause
        exit
    end Start
