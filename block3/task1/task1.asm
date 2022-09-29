include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_1 (блок_3) 'Алгебраическая сумма' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        outstr 'Введите формулу: '
        mov EAX, 0
        
L:      inchar AL
        cmp AL, '.'
        je fin
        cmp AL, ')'
        je calc
        cmp AL, '('
        je L
        cmp AL, '+'
        jne @F
        push EAX
        jmp L
@@:     cmp AL, '-'
        jne @F
        push EAX
        jmp L
@@:     sub EAX, '0'
        push EAX
        jmp L
        
calc:   pop EBX
        pop ECX
        pop EDX
        cmp ECX, '+'
        je plus
        sub EDX, EBX
        push EDX
        jmp L
plus:   add EDX, EBX
        push EDX
        jmp L
        
fin:    pop EAX
        outint EAX,,'Ответ = '
        
        pause
        exit
    end Start
