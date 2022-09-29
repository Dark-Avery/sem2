include console.inc
; (“≈—“џ ƒЋя Ё“јѕќ¬ 1,2,3 -  в конце этой программы)
; ќѕ»—јЌ»≈ “»ѕќ¬ («јѕ»—») » (—“–” “”–џ):
; ¬нимание, нельз€ вносить изменени€ в описани€ типов и переменных: 
Date_pack record D:5, M:4, Y:7
Date_unpack struc  ; дата в рамках некоторого столети€
D   db ?           ; день (от 1 до 31)
M   db ?           ; мес€ц (от 1 до 12)
Y   db ?           ; год (от 0 до 99)
Date_unpack ends

; ќѕ»—јЌ»≈ ѕ≈–≈ћ≈ЌЌџ’:
.data
T   db " ‘јћ»Ћ»я______ »ћя______    Ё“јѕ_1 (выход-4)",0	;	
N   equ 6
D1  Date_pack <>                    ; упакованна€ дата_1
D2  Date_pack <>                    ; упакованна€ дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив записей (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>) ; массив структур (распакованных дат)

; ќѕ»—јЌ»≈ ѕ–ќ÷≈ƒ”–: 
.code
; -----------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; действие: ввод значений полей D, M, Y записи типа Date_pack
In_Rec proc
    push EBP
    mov EBP, ESP
    
    push ECX
    push EAX
    push EBX
    
    mov ECX, [EBP + 8]
    
    inint AX
    shl AX, D
    inint BX
    shl BX, M
    add AX, BX
    inint BX
    shl BX, Y
    add AX, BX
    mov [ECX], AX
    
    pop EBX
    pop EAX
    pop ECX
    pop EBP
    
    ret 4

In_Rec endp
; -----------------------------------------------------
; function Less(D1, D2: Date_pack): byte
; AL := 1 (если D1<D2, т.е. если дата_1 предшествует дате_2)
; AL := 0 (иначе)
Less proc

    push EBP
    mov EBP, ESP
    
    push ECX
    push EBX
    
    mov AL, 1
    mov CX, [EBP + 12]         ;D2
    and CX, mask Y
    
    mov BX, [EBP + 8]          ;D1
    and BX, mask Y
    
    cmp BX, CX
    jB @fin
    jA @fin1
    
    mov CX, [EBP + 12]         ;D2
    and CX, mask M
    
    mov BX, [EBP + 8]          ;D1
    and BX, mask M
    
    
    cmp BX, CX
    jB @fin
    jA @fin1
    
    mov CX, [EBP + 12]         ;D2
    and CX, mask D
    
    mov BX, [EBP + 8]          ;D1
    and BX, mask D
    
    cmp BX, CX
    jB @fin
    jA @fin1
    
@fin1:
    mov AX, 0

@fin:
    
    pop EBX
    pop ECX
    pop EBP
    
    ret 2*4

Less endp
; -----------------------------------------------------
; procedure Out_Rec(D: Date_pack)
; действие: вывод значений полей D, M, Y записи типа Date_pack
Out_Rec proc
    push EBP
    mov EBP, ESP
    
    push ECX
    push EBX
    
    
    mov CX, [EBP + 8]
    mov BX, CX
    
    and BX, mask D
    shr BX, D
    outint BX
    outstr '.'
    mov BX, CX
    and BX, mask M
    shr BX, M
    outint BX
    outstr '.'
    mov BX, CX
    and BX, mask Y
    shr BX, Y
    outint BX
    
    
    pop EBX
    pop ECX
    pop eBP
    
    ret 4
  
Out_Rec endp
; -----------------------------------------------------
; function Min_Date(var Arr: array of Date_pack; N: longword): word
; действие: ј’ := минимальна€ дата среди элементов-дат массива Arr
; (минимальна€ - предшествующа€ всем остальным датам)
; ‘ункци€ Min_Date в процессе своей работы дл€ сравнени€ текущего минимума 
; с очередной датой обращаетс€ к ранее отлаженной функции Less(D1,D2)
Min_Date proc
    push EBP
    mov EBP, ESP
    
    push EBX
    push ECX
    push EDX
    
    mov EDX, [EBP + 8]
    mov EBX, 0
    mov BX, [EDX]
    
    mov ECX, [EBP + 12]
    dec ECX
    
@L:
    movzx EAX, word ptr [EDX + 2]
    push EAX
    push EBX
    call Less
    
    cmp AL, 1
    jE @next
    mov BX, [EDX + 2]
@next:
    add EDX, 2
    loop @L
    
    mov AX, BX
    
    pop EDX
    pop eCX
    pop EBX
    pop EBP
    
    ret 2*4
Min_Date endp
; -----------------------------------------------------
; procedure Rec_to_Struс(D_pack: Date_pack; var D_unpack: Date_unpack)
; действие: распаковка даты 
; (из записи типа Date_pack в структуру типа Date_unpack)
Rec_to_Struc proc
    push EBP
    mov EBP, ESP
    
    push ECX
    push ESI
    push EBX
    
    mov CX, [EBP + 8]
    mov ESI, [EBP + 12]
    
    mov BX, CX
    and BX, mask D
    ror BX, D
    mov (Date_unpack ptr [ESI]).D, BL
    
    mov BX, CX
    and BX, mask M
    ror BX, M
    mov (Date_unpack ptr [ESI]).M, BL
    
    mov BX, CX
    and BX, mask Y
    ror BX, Y
    mov (Date_unpack ptr [ESI]).Y, BL
    
    pop EBX
    pop eSI
    pop ECX
    pop eBP
    ret 2*4
    
    
Rec_to_Struc endp
; -----------------------------------------------------
; procedure Out_Struc(var D: Date_unpack)
; действие: вывод значений полей D, M, Y структуры типа Date_unpack
Out_Struc proc

    push ebp
    mov EBP, ESP
    
    push EBX
    
    mov EBX, [EBP +8]
    outint (Date_unpack ptr [EBX]).D
    outstr '.'
    outint (Date_unpack ptr [EBX]).M
    outstr '.'
    outint (Date_unpack ptr [EBX]).Y
    outstr '  '
    pop EBX
    pop eBP
    ret 4
    
    
Out_Struc endp
; -----------------------------------------------------
; ¬≈ƒ”ўјя „ј—“№ (ќ—Ќќ¬Ќјя ѕ–ќ√–јћћј):
start:	
    ConsoleTitle offset T	
; ----------------------------------------------------- 
; Ё“јѕ 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (кажда€ в формате dd.mm.yy)
; решение:
COMMENT *
    push offset D1
    call In_Rec
    
    
    push offset D2
    call In_Rec
    
; (20 очков) сравнение двух дат (D1 < D2 ?)
; решение:
    movzx EBX, D2
    push EBX
    movzx EBX, D1
    push EBX
    call Less
    
; (10 очков) вывод результата сравнени€ в виде "D1<D2 is true/false",
; где вместо D1 и D2 должна быть напечатана дата в формате dd.mm.yy
; решение:
    movzx EBX, D1
    push EBX
    call Out_Rec
    
    outchar 60
    
    movzx EBX, D2
    push EBX
    call Out_Rec
    
    
    cmp AL, 1
    jE next1
    outstr '   false'
    jmp next2
next1:
    outstr '   true'
next2:
*
; ----------------------------------------------------- 
; Ё“јѕ 2 (50 очков):
; (15 очков) цикл дл€ ввода N дат и сохранени€ их в массиве Arr_of_Rec:
; решение:

    mov ECX, N
    lea EBX, Arr_of_Rec
L1:
    push EBX
    call In_Rec
    add EBX, 2
    loop L1
    
; (15 очков) цикл дл€ вывода N дат, хран€щихс€ в массиве Arr_of_Rec
; решение:
    mov ECX, N
    lea EBX, Arr_of_Rec
L2:
    movzx EAX, word ptr [EBX]
    push EAX
    call Out_Rec
    outstr '  '
    add EBX, 2
    loop L2  
    
    mov ECX, N - 1
    lea EBX, Arr_of_Rec
; (20 очков) цикл дл€ проверки упор€дочены ли элементы-даты по возрастанию
; решение:
L3:
    movzx EDX, word ptr [EBX + 2]
    push EDX
    movzx EDX, word ptr [EBX]
    push EDX
    call Less
    add EBX, 2
    cmp AL, 1
    jNE next3
    loop L3
    outstr '   sorted'
    jmp next4
next3:
    outstr '   not sorted'
next4:
    
    






; ----------------------------------------------------- 
; Ё“јѕ 3 (40 очков):
; применение функции Min_Date дл€ поиска наименьшей даты в массиве Arr_of_Rec
; решение:
    
    push N
    lea EBX, Arr_of_Rec
    push EBX
    call Min_Date
    
    newline
    
    outstr 'minimum =   '
    movzx EAX, AX
    push EAX
    call Out_Rec
    
    newline

    


; вывод наименьшей даты в виде "dd.mm.yy is minimum"
; решение:


; ----------------------------------------------------- 
; Ё“јѕ 4 (60 очков):
; (30 очков) цикл движени€ по массиву Arr_of_Rec с целью распаковки дат 
; и сохранени€ их в массиве структур  Arr_of_Struc
; решение:

    mov ECX, N
    lea EBX, Arr_of_Rec
    lea EAX, Arr_of_Struc
L4:
    push EAX
    movzx ESI, word ptr [EBX]
    push ESI
    call Rec_to_Struc
    add EBX, 2
    add EAX, type Arr_of_Struc
    loop L4
    
    mov ECX, N
    lea EAX, Arr_of_Struc
    
    outstr 'ѕолученна€ структура : '
L5:
    push EAX
    call Out_Struc
    add EAX, 3
    loop L5
    
    


; (30 очков) цикл движени€ по массиву Arr_of_Struc с целью вывода дат 
; на экран (каждую дату - в формате dd.mm.yy)
; решение


; ----------------------------------------------------- 
	
	pause
	exit
	end start
	
“≈—“џ, на которых надо сдавать программу:
---------------------------------------------------------
Ё“јѕ 1
---------------------------------------------------------
1)  10.2.20 13.2.20	   ===>   10.2.20<13.2.20 is true
2)  20.2.20 10.3.20	   ===>   20.2.20<10.3.20 is true  
3)  15.2.20 10.2.21	   ===>   15.2.20<10.2.21 is true  
4)  1.2.3 1.2.3	       ===>   1.2.3<1.2.3 is false
5)  10.2.20 15.1.20	   ===>   10.2.20<15.1.20 is false
6)  9.2.20 10.2.19	   ===>   9.2.20<10.2.19 is false
---------------------------------------------------------
Ё“јѕ 2
---------------------------------------------------------
1)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 15.4.20	===> sorted
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.20	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
---------------------------------------------------------
Ё“јѕ 3
---------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
---------------------------------------------------------
