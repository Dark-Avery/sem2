include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_1 (блок_2) 'Первые вхождения' ",0       ; информация о решаемой задаче
LAT db 'Z'-'A'+1 dup(0)
.code
    Start:

        ConsoleTitle offset T
        
        mov EAX, 0
        outstr 'Введите текст: '
L:      inchar AL
        cmp AL,'.'
        je fin
        cmp LAT[EAX-'A'],1
        je L
        mov LAT[EAX-'A'],1
        outchar AL
        jmp L
        
        
fin:    pause
        exit
    end Start
