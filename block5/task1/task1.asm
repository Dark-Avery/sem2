include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_1 (блок_5) 'Ввод-вывод двоичного числа' ",0

.code
    Start:
        ConsoleTitle offset T
        xor EAX, EAX
L1:     inchar DL
        cmp DL, ' '
        je @F
        sub DL, '0'
        shl EAX, 1
        or AL, DL
        jmp L1
        
@@:     mov ECX, 32
L2:     shl EAX, 1
        jc @F
        loop L2
        
@@:     jECXZ next
L3:     mov DL, 0
        adc DL, 0
        outword DL
        shl EAX, 1
        loop L3
        jmp fin
next:   outword 0
        
fin:    newline
        pause
        exit
    end Start
