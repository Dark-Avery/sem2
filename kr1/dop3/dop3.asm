include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_3 (выход 1) ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        inchar AL
        cmp AL, '0'
        je zero
        jb fin
        cmp AL, '9'
        ja fin
        mov ECX, 1
        
L:      inchar AL
        cmp AL, 'h'
        je kon
        cmp AL, 'A'
        jne fin
        cmp AL, 'a'
        j
        inc ECX
        
        pause
        exit
    end Start
