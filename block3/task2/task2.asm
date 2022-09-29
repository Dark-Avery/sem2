include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_2 (блок_3) 'Max/Min' ",0       ; информация о решаемой задаче

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
        cmp AL, ','
        je L
        cmp AL, 'M'
        jne @F
        push EAX
        jmp L
@@:     cmp AL, 'm'
        jne @F
        push EAX
        jmp L
@@:     sub EAX, '0'
        push EAX
        jmp L
        
calc:   pop EBX
        pop ECX
        pop EDX
        cmp EDX, 'M'
        je max
        cmp EBX, ECX
        ja @F
        push EBX
        jmp L
@@:     push ECX
        jmp L
max:    cmp EBX, ECX
        ja @F
        push ECX
        jmp L
@@:     push EBX
        jmp L
        
fin:    pop EAX
        outint EAX,,'Ответ = '
        
        pause
        exit
    end Start
