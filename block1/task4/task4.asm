include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_4 (блок_1) 'Дробь P/Q' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        outstrln 'Введите дробь P/Q: '
        inintln EAX, 'P = '
        inintln EBX, 'Q = '
        mov EDX, 0
        div EBX
        mov ESI, 10
        outword EAX,,'Ответ: '
        outchar '.'
        
        mov ECX, 5        
L:      xchg EAX, EDX
        mov EDX, 0
        mul ESI
        div EBX
        outword EAX
        loop L
        
        pause
        exit
    end Start
