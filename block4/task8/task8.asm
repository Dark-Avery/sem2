include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_8 (блок_4) 'Наибольший общий делитель' ",0

.code
    GCD proc
        push EBP
        mov EBP, ESP
        push ECX
        
        mov EAX, [EBP+8]
        mov ECX, [EBP+12]
        
        cmp ECX, 0
        je @F
        cmp EAX, 0
        xchg EAX, ECX
        je @F
        
        cmp EAX, ECX
        je @F
        ja @bol
        xchg EAX, ECX
@bol:   sub EAX, ECX   
        push ECX
        push EAX
        call GCD
        
@@:     pop ECX
        pop EBP
        ret 4*2
    GCD endp
    
    Start:
        ConsoleTitle offset T
        inint ECX,'Введите 2 числа: '
        inint EBX
        
        push ECX
        push EBX
        call GCD
        outwordln EAX,,'НОД = '
        
        pause
        exit
    end Start
