include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_0 (блок_0) 'Название' ",0

.code
    Start:

        ConsoleTitle offset T

        
        pause
        exit
    end Start
