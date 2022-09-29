include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_1 (Выход 1) ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T
        mov ECX, 256
        mov EBX, 10
        
L:      mov EAX, ECX    ;максимальное возможное число
        mov EDX, 0      ;которое может уместиться в
        div EBX         ;остаток и целую часть при коротком делении
        cmp EDX, 255    ;это число 2^8 - 1
        ja fin
        cmp EAX, 255
        ja fin
        inc ECX
        mov ESI, EAX
        mov EDI, EDX
        jmp L
        
fin:    dec ECX
        outwordln ECX,,'Ответ: '
        outwordln ESI,,'Целая часть: '
        outwordln EDI,,'Остаток: '
        
        pause
        exit
    end Start
