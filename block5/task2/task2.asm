include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_2 (блок_5) 'Ввод-вывод шестнадцатеричного числа' ",0
dig16 db '0123456789ABCDEF'
.code
    Start:
        ConsoleTitle offset T
        xor EAX, EAX
input:  inchar BL
        cmp BL, ' '
        je endin
        cmp BL, '9'
        ja @F
        sub BL, '0'
        jmp next
@@:     sub BL, 'A'
        add BL, 10
next:   shl EAX, 4
        or AL, BL
        jmp input
        
endin:  mov ECX, 8
output: rol EAX, 4
        mov EBX, EAX
        and EBX, 1111b
        outchar dig16[EBX]
        loop output
        
        pause
        exit
    end Start
