include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_9 (блок_1) 'Первая и последняя буквы' ",0       ; информация о решаемой задаче

.code
    Start:
        ConsoleTitle offset T
        mov ESI, 0
        inchar AL,'Введите слова через запятую: '
        
outo:   mov BL, AL
        mov CL, AL
        inchar AL
        
ino:    cmp AL, '.'
        je exitc
        cmp AL, ','
        je exitc
        mov CL, AL
        inchar AL
        jmp ino
        
exitc:  cmp BL, CL
        jne bword
        inc ESI
        
bword:  cmp AL, '.'
        je fin
        inchar AL
        jmp outo
        
fin:    outintln ESI,,'Ответ: '
        
        pause
        exit
    end Start
