include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "   ; информация об авторе программы
    db " Задача_9 (блок_2) 'Минимальный элемент матрицы' ",0       ; информация о решаемой задаче
N   equ 4
M   equ 6
A   dd N dup(M dup(?))
.code
    Start:
        ConsoleTitle offset T
        outstr 'Введите матрицу размера '
        outint N
        outintln M,,'x'
        newline
        inint EBX       ;read(min)
        mov A, EBX
        mov EAX, 1
        mov EBP, 1
        
input:  inint A[EAX*4]
        cmp EBX, A[EAX*4]
        jne next
        inc EBP
next:   cmp EBX, A[EAX*4]
        jLE @F
        mov EBX, A[EAX*4]
        mov EBP, 1
@@:     inc EAX
        cmp EAX, N*M
        jb input
        
        newline
        outint EBX,,'Минимальный элемент '
        outint EBP,,' входит '
        outstrln ' раз.'
        newline
        outstr 'Индексы его вхождений: '
        
        mov EAX, 0
        mov ESI, 4*M
L:      mov ECX, 0
Li:     cmp A[ECX*4][EAX], EBX
        jne nextel
        mov EDI, EAX 
        mov EDX, 0
        div ESI
        inc EAX
        inc ECX
        outint EAX,,' ['
        outint ECX,,','
        outchar ']'
        dec ECX
        dec EBP
        mov EAX, EDI
        cmp EBP, 0
        je fin
nextel: inc ECX
        cmp ECX, M
        jb Li
        
        add EAX, 4*M
        cmp EAX, 4*N*M
        jb L
        
fin:    newline

        pause
        exit
    end Start