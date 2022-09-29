include console.inc
COMMENT *
Читаю посимвольно число до энтера и заношу его в массив
Потом делаю цикл из пяти шагов по кол-ву строчек матрицы образца
Копирую из матрицы образца в массив ответ по строчкам из 6 эл-тов
(Место откуда копируется выбирается путем взятия из массива символа числа
и домножением его на 6 плюс кол-во элементов в строке mul номер строки)
После последнего элемента в массив ответ заношу 0 для вывода строкой
*
.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Доп_1 (выход 3) ",0
obr db ' 000    1    222  3333  4   4 55555  666  77777  888   999  '
    db '0   0  11   2   2     3 4   4 5     6         7 8   8 9   9 '
    db '0   0   1      2   333  44444 5555  6666     7   888   9999 '
    db '0   0   1    22       3     4     5 6   6   7   8   8     9 '
    db ' 000   111  22222 3333      4 5555   666   7     888   999  '
ans db 350 dup(?)
dig db 9 dup(?)
.code
    Start:
        ConsoleTitle offset T
        outstr 'Введите число: '
        xor ECX, ECX
input:  inchar AL
        cmp AL, '0'
        je input
        
inputi: cmp AL, 10
        jne @F
        jmp next
@@:     mov dig[ECX], AL
        inc ECX
        inchar AL
        cmp ECX, 10
        jb inputi
        
        
next:   flush
        newline
        xor ESI, ESI
        mov EAX, 5
        xor EBX, EBX
        dec ECX         ;кол-во цифр
        cmp ECX, 0
        jle term
        
Loo:    xor EDI, EDI
        push EAX
        push ECX
        
Lo:     xor EAX, EAX
        mov AL, dig[EDI]
        sub AL, '0'
        mov DL, 6
        mul DL
        push ECX
        mov ECX, 6
Li:     mov DL, obr[EAX][ESI]
        mov ans[EBX], DL
        inc EBX
        inc EAX
        loop Li
        pop ECX
        inc EDI
        loop Lo
        
        pop ECX
        mov ans[EBX], 10
        inc EBX
        mov ans[EBX], 13
        inc EBX
        add ESI, 60
        pop EAX
        dec EAX
        cmp EAX, 0
        jne Loo
        
        mov ans[EBX], 0
        
        lea ESI, ans
        outstr ESI
        
term:   newline
        pause 'Нажмите любую клавишу...'
        exit
    end Start
