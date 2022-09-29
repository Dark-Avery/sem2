include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_2 (блок_2) 'Зачёт с оценкой' ",0       ; информация о решаемой задаче
z2  db 'неуд',0
z3  db 'удовл',0
z4  db 'хорошо',0
z5  db 'отлично',0
adr dd z2,z3,z4,z5
.code
    Start:

        ConsoleTitle offset T
        inint EAX,'Введите оценку: '
        mov EBX, adr[4*EAX-8]
        outstrln EBX
        
        pause
        exit
    end Start
