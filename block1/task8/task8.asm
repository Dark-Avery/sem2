include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_8 (блок_1) 'Алгебраическая сумма' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        inchar AL,'Введите алгебраическую сумму: '
        sub AL, '0'
        movzx ECX, AL
        
L:      inchar AL
        cmp AL, '.'
        je fin
        cmp AL, '+'
        je plus
        cmp AL, '-'
        je minus
        
plus:   inchar AL
        sub AL, '0'
        movzx EAX, AL
        add ECX, EAX
        jmp L
        
minus:  inchar AL
        sub AL, '0'
        movzx EAX, AL
        sub ECX, EAX
        jmp L
        
fin:    outintln ECX,,'Ответ: '
        
        pause
        exit
    end Start
