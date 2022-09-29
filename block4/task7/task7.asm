include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_7 (блок_4) 'Отрицательные и положительные числа' ",0

.code
    Reverse proc
        push ECX
        
        inint ECX
        cmp ECX, 0
        je @F
        jG @pol
        jL @otr
        
@pol:   call Reverse
        outint ECX
        outchar ' '
        jmp @F
        
@otr:   outint ECX
        outchar ' '
        call Reverse
        
@@:     pop ECX
        ret
    Reverse endp
    
    Start:
        ConsoleTitle offset T
        outstrln 'Введите посл-ность чисел:'
        call Reverse
        newline
        
        pause
        exit
    end Start
