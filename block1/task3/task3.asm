include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_3 (блок_1) 'Баланс скобок' ",0
S   db 'нет',0,'да',0

.code
    Start:
        Cls
        ConsoleTitle offset T 
        
        lea ESI, S
        mov EAX, 0
        inchar CL, 'Введите последовательность: '
        outstr 'Баланс скобок - '
        
L:      cmp CL, '.'
        je fin
        cmp CL, '('
        je open
        cmp CL, ')'
        je close
        
check:  cmp EAX, 0
        jL outp
        inchar CL
        jmp L
        
open:   inc EAX
        jmp check
        
close:  dec EAx
        jmp check
        
fin:    cmp EAX, 0
        jne outp
        lea ESI, S+4
        
outp:   outstrln ESI
        
        pause               
        exit                
    end Start
