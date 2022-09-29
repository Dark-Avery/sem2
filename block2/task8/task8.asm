include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_8 (блок_2) 'Палиндром?' ",0       ; информация о решаемой задаче
N   equ 30
S   db N dup(?)
A   db 'не палиндром',0
.code
    Start:

        ConsoleTitle offset T
        lea ESI, A
        
        mov EAX, 0
input:  inchar DL
        cmp DL, '.'
        je @F
        mov S[EAX], DL
        inc EAX
        cmp EAX, N
        jb input
        
@@:     lea EDI, S
        lea EDX, S[EAX-1]
        
L:      mov AL, [EDI]
        inc EDI
        cmp AL, ' '
        je L
        
@@:     mov CL, [EDX]
        dec EDX
        cmp CL, ' '
        je @B
        
        cmp AL, CL
        je @F
        add CL, 'A'-'a'
        cmp AL, CL
        je @F
        add AL, 'A'-'a'
        cmp AL, CL
        je @F
        sub CL, 'A'-'a'
        cmp AL, CL
        jne print
@@:     cmp EDI, EDX
        jB L
        
        lea ESI, A+3

print:  outstrln ESI
        
        pause
        exit
    end Start
