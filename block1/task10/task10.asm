include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_10 (блок_1) 'Таблица умножения' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        outstrln '        Таблица умножения'
        outstrln '  |  0  1  2  3  4  5  6  7  8  9'
        outstrln '---------------------------------'
        mov ECX, 10
        mov EAX, 0
        
L:      outint EAX
        outstr ' |'
        
        mov EDX, 0
        mov EBX, 0
Li:     outint EBX, 3
        add EBX, EAX
        inc EDX
        cmp EDX, 9
        jbe Li
        newline
        
        inc EAX
        dec ECX
        cmp ECX, 0
        jne L
        
        
        
        pause
        exit
    end Start
