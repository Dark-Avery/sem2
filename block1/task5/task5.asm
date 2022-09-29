include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_5 (блок_1) 'Произведение старшей и младшей десятичных цифр' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        inint EAX, 'Введите число: '
        mov EBX, 10
        mov EDX, 0
        div EBX
        mov ECX, EDX
        cmp EAX, 0
        je one
        
L:      cmp EAx, EBX
        jb fin
        mov EDX, 0
        div EBX
        jmp L
        
one:    xchg EAX, EDX
        
fin:    outint EAX
        outstr ' * '
        outint ECX
        mul ECX
        outintln EAX,,' = '
        
        pause
        exit
    end Start
