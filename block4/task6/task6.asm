include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_6 (блок_4) 'Текст наоборот' ",0

.code
    Reverse proc
        push ECX
        
        inchar CL
        cmp CL, '.'
        je @F
        
        call Reverse
        outchar CL
        
@@:     pop ECX
        ret
    Reverse endp
    
    Start:
        ConsoleTitle offset T
        outstrln 'Введите текст:'
        call Reverse
        newline
        
        pause
        exit
    end Start
