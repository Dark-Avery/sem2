include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_2 (блок_4) 'Матрицы (прямоугольные и квадратные)' ",0
MaxSize equ 150
n db ?
m db ?
X dw MaxSize dup(?)
.code
    Print proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push EDX
        push EDI
        push ESI
        
        mov EDI, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m
        mov EAX, [EBP+16]   ;n
        
        xor ESI, ESI
@Lo:    outchar '|'
        xor EDX, EDX
@Li:    outint word ptr [2*EDX][EDI], 6
        inc EDX
        cmp EDX, EBX
        jb @Li
        outcharln '|'
        inc ESI
        add EDI, EBX
        add EDI, EBX
        cmp ESI, EAX
        jb @Lo
        newline
        
        pop ESI
        pop EDI
        pop EDX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    Print endp
    
    Sorted proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        mov ECX, [EBP+16]   ;n строк
        
        outstr '1) Строки, в которых эл-ты упорядочены по неубыванию:'
        
        xor ESI, ESI
@Lo:    xor EDX, EDX
        mov DI, [2*EDX][EAX]
        inc EDX
@Li:    cmp [2*EDX][EAX], DI
        jL @next
        mov DI, [2*EDX][EAX]
        inc EDX
        cmp EDX, EBX
        jb @Li
        inc ESI
        outint ESI,, ' '
        dec ESI
@next:  inc ESI
        add EAX, EBX
        add EAX, EBX
        cmp ESI, ECX
        jb @Lo
        newline
        
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    Sorted endp
    
    SymStr proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        
        outstr '2) Симметричные строки:'
        
        xor ESI, ESI
@Lo:    xor EDX, EDX
        mov ECX, EBX
@Li:    mov DI, [2*EDX][EAX]
        cmp DI, [2*ECX-2][EAX]
        jne @next
        inc EDX
        dec ECX
        cmp EDX, ECX
        jb @Li
        inc ESI
        outint ESI,, ' '
        dec ESI
@next:  inc ESI
        add EAX, EBX
        add EAX, EBX
        cmp ESI, [EBP+16]   ;n строк
        jb @Lo
        newline
        
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    SymStr endp
    
    Same proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        mov ECX, [EBP+16]   ;n строк
        
        outstr '3) Строки, в которых эл-ты одинаковы:'
        
        xor ESI, ESI
@Lo:    xor EDX, EDX
        mov DI, [2*EDX][EAX]
        inc EDX
@Li:    cmp word ptr [2*EDX][EAX], DI
        jne @next
        inc EDX
        cmp EDX, EBX
        jb @Li
        inc ESI
        outint ESI,, ' '
        dec ESI
@next:  inc ESI
        add EAX, EBX
        add EAX, EBX
        cmp ESI, ECX
        jb @Lo
        newline
        
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    Same endp
    
    Gdiag proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        mov ECX, [EBP+16]   ;n строк
        
        outstr '4) Эл-ты главной диагонали:'
        
        xor ESI, ESI
        xor EDX, EDX
@L:     outint word ptr [2*EDX][EAX],, ' '
        add EDX, EBX
        inc EDX
        inc ESI
        cmp ESI, ECX
        jb @L
        newline
        
        pop ESI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    Gdiag endp
    
    Pdiag proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        mov ECX, [EBP+16]   ;n строк
        
        outstr '5) Эл-ты побочной диагонали:'
        
        xor ESI, ESI
        mov EDX, EBX
        dec EDX
@L:     outint word ptr [2*EDX][EAX],, ' '
        add EDX, EBX
        dec EDX
        inc ESI
        cmp ESI, ECX
        jb @L
        newline
        
        pop ESI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    Pdiag endp
    
    SymMatr proc
        push EBP
        mov EBP, ESP
        sub ESP, 4
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]    ;array
        mov EBX, [EBP+12]   ;m элементов в строке
        outstr '6) Матрица '
        
        mov dword ptr [EBP-4], 2
        mov ECX, EBX
        dec ECX
        mov EDX, 1
        
@Lo:    mov ESI, EBX
        dec ESI
        push ECX
@Li:    mov DI, [EDX*2][EAX]
        add EAX, ESI
        add EAX, ESI
        cmp DI, [EDX*2][EAX]
        jne @wrong
        sub EAX, ESI
        sub EAX, ESI
        inc EDX
        add ESI, EBX
        dec ESI
        dec ECX
        cmp ECX, 0
        jne @Li
        
        pop ECX
        add EDX, [EBP-4]
        inc dword ptr [EBP-4]
        dec ECX
        cmp ECX, 0
        jne @Lo
        jmp @nwrong
        
@wrong: pop ECX
        outstr 'не '
@nwrong:outstrln 'симметрична'
        
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
        
        ret 4*3
    SymMatr endp
    
    Start:
        ConsoleTitle offset T
start:  Cls
        outstrln 'Кол-во строк или столбцов должно быть больше 1'
        outstrln 'Кол-во элементов не больше 150'
        inint n, 'Кол-во строк матрицы: '
        inint m, 'Кол-во столбцов матрицы: '
        mov AL, n
        mov BL, m
        cmp AL, 0
        je wrong
        cmp AL, 1
        je wrong
        cmp BL, 0
        je wrong
        cmp BL, 1
        je wrong
        mul BL
        cmp AX, MaxSize
        ja wrong
        jmp nwrong
        
wrong:  flush
        inchar DL, 'Вы ошиблись. Попробуете еще раз? Y/N '
        cmp DL, 'Y'
        je start
        cmp DL, 'N'
        je term
        jmp wrong
        
nwrong: outstrln 'Введите матрицу'
        xor ECX, ECX
        movzx EAX, n
        movzx EBX, m
        mov EDX, 0
        mul EBX
        
input:  inint X[2*ECX]
        inc ECX
        cmp ECX, EAX
        jb input
        flush
        
        newline
        movzx EAX, n
        movzx EBX, m
        lea ECX, X
        
        push EAX
        push EBX
        push ECX
        call Print
        
        push EAX
        push EBX
        push ECX
        call Sorted
        
        push EAX
        push EBX
        push ECX
        call SymStr
        
        push EAX
        push EBX
        push ECX
        call Same
        
        cmp EAX, EBX
        jne term
        
        push EAX
        push EBX
        push ECX
        call Gdiag
        
        push EAX
        push EBX
        push ECX
        call Pdiag
        
        push EAX
        push EBX
        push ECX
        call SymMatr
        
again:  newline
        inchar DL, 'Хотите работать с новой матрицей? Y/N '
        cmp DL, 'Y'
        je start
        cmp DL, 'N'
        je term
        jmp again

term:   newline
        pause 'Нажмите любую клавишу...'
        exit
    end Start
