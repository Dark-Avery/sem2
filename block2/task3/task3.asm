include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_3 (блок_2) 'Картинка' ",0       ; информация о решаемой задаче
S   db 20 dup('-'),0
.code
    Start:
        
        ConsoleTitle offset T
        inint ECX,'Введите число от 0 до 20: '
        mov S[ECX],0
        mov EBX, ECX
        lea EDX, S
        

L:      dec EBX
        mov S[EBX], '*'
        outstrln EDX
        dec ECX
        cmp ECX, 0
        jg L
        
fin:    pause
        exit
    end Start
