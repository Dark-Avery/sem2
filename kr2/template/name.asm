include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_0 (блок_0) 'Название' ",0       ; информация о решаемой задаче

.code
    Start:

        ConsoleTitle offset T

        
        pause
        exit
    end Start
