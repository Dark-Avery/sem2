include console.inc
; (ТЕСТЫ ДЛЯ ЭТАПОВ 1,2,3 -  в конце этой программы)
; ОПИСАНИЕ ТИПОВ (ЗАПИСИ) И (СТРУКТУРЫ):
; Внимание, нельзя вносить изменения в описания типов и переменных: 
Date_pack record D:5, M:4, Y:7
Date_unpack struc  ; дата в рамках некоторого столетия
D   db ?           ; день (от 1 до 31)
M   db ?           ; месяц (от 1 до 12)
Y   db ?           ; год (от 0 до 99)
Date_unpack ends

; ОПИСАНИЕ ПЕРЕМЕННЫХ:
.data
T   db " Зянчурин Игорь   ЭТАП_1 (выход-4)",0	;	
N   equ 6
D1  Date_pack <>                    ; упакованная дата_1
D2  Date_pack <>                    ; упакованная дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив записей (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>) ; массив структур (распакованных дат)
tr  db 'true',0
fls db 'false',0
ans db 'не упорядочен строго по возрастанию',0
; ОПИСАНИЕ ПРОЦЕДУР: 
.code
; -----------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; действие: ввод значений полей D, M, Y записи типа Date_pack
In_Rec proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EBX, [EBP+8]
    inint AX
    shl AX, D
    inint CX
    shl CX, M
    or AX, CX
    inint CX
    or AX, CX
    mov [EBX], AX
    
    pop ECX
    pop EBx
    pop EAX
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
    push EBX
    push EDX
    push EDI
    push ESI
    
    xor AL, AL
    mov DX, [EBP+8]     ;D1
    mov BX, [EBP+12]    ;D2
    
    mov DI, mask Y
    and DI, DX
    mov SI, mask Y
    and SI, BX
    cmp DI, SI
    jb @g
    ja @bad
    
    mov DI, mask M
    and DI, DX
    mov SI, Mask M
    and SI, BX
    cmp DI, SI
    jb @g
    ja @bad
    
    mov DI, mask D
    and DI, DX
    mov SI, mask D
    and SI, BX
    cmp DI, SI
    jnb @bad
    
@g: inc AL

@bad:
    pop ESI
    pop EDI
    pop EDX
    pop EBX
    pop EBP
    ret 4*2
Less endp
; -----------------------------------------------------
; procedure Out_Rec(D: Date_pack)
; действие: вывод значений полей D, M, Y записи типа Date_pack
Out_Rec proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    
    mov EAX, [EBP+8]
    
    mov BX, mask D
    and BX, AX
    shr BX, D
    outword BX
    outchar '.'
    
    mov BX, mask M
    and BX, AX
    shr BX, M
    outword BX
    outchar '.'
    
    mov BX, mask Y
    and BX, AX
    outword BX
    
    pop EBX
    pop EAX
    pop EBP
    ret 4
Out_Rec endp
; -----------------------------------------------------
; function Min_Date(var Arr: array of Date_pack; N: longword): word
; действие: АХ := минимальная дата среди элементов-дат массива Arr
; (минимальная - предшествующая всем остальным датам)
; Функция Min_Date в процессе своей работы для сравнения текущего минимума 
; с очередной датой обращается к ранее отлаженной функции Less(D1,D2)
Min_Date proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EBX, [EBP+8]
    mov ECX, [EBP+12]
    
    mov DX, [EBX]
    dec ECX
    
@L: movzx EDI, DX
    movzx ESI, word ptr [EBX][2*ECX]
    push ESI
    push EDI
    call Less
    cmp AL, 1
    je @F
    mov DX, [EBX][2*ECX]
    
@@: dec ECX
    jnz @L
    
    mov AX, DX
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Min_Date endp
; -----------------------------------------------------
; procedure Rec_to_Struс(D_pack: Date_pack; var D_unpack: Date_unpack)
; действие: распаковка даты 
; (из записи типа Date_pack в структуру типа Date_unpack)
Rec_to_Struc proc
    push EBP
    mov EBP, ESP
    push EAX
    push ECX
    push ESI
    
    mov ESI, [EBP+8]
    mov CX, [EBP+12]
    
    mov AX, mask D
    and AX, CX
    shr AX, D
    mov (Date_unpack ptr [ESI]).D, AL
    mov AX, mask M
    and AX, CX
    shr AX, M
    mov (Date_unpack ptr [ESI]).M, AL
    mov AX, mask Y
    and AX, CX
    mov (Date_unpack ptr [ESI]).Y, AL
    
    pop ESI
    pop ECX
    pop EAX
    pop EBP
    ret 4*2
Rec_to_Struc endp
; -----------------------------------------------------
; procedure Out_Struc(var D: Date_unpack)
; действие: вывод значений полей D, M, Y структуры типа Date_unpack
Out_Struc proc
    push EBP
    mov EBP, ESP
    push ESI
    
    mov ESI, [EBP+8]
    
    outword (Date_unpack ptr [ESI]).D
    outchar '.'
    outword (Date_unpack ptr [ESI]).M
    outchar '.'
    outwordln (Date_unpack ptr [ESI]).Y
    
    pop ESI
    pop EBP
    ret 4
Out_Struc endp
; -----------------------------------------------------
; ВЕДУЩАЯ ЧАСТЬ (ОСНОВНАЯ ПРОГРАММА):
start:	
    ConsoleTitle offset T	
; ----------------------------------------------------- 
; ЭТАП 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (каждая в формате dd.mm.yy)
; решение:
comment ~
    outstrln '1st data'
    push offset D1
    call In_Rec
    outstrln '2nd data'
    push offset D2
    call In_Rec
; (20 очков) сравнение двух дат (D1 < D2 ?)
; решение:
    movzx EBX, D2
    movzx ECX, D1
    push EBX
    push ECX
    call Less
    lea ESI, fls
    cmp AL, 0
    je @F
    lea ESI, tr
; (10 очков) вывод результата сравнения в виде "D1<D2 is true/false",
; где вместо D1 и D2 должна быть напечатана дата в формате dd.mm.yy
; решение:
@@: push D1
    call Out_Rec
    outchar ' '
    outchar 60
    outchar ' '
    push D2
    call Out_Rec
    outstr ' is '
    outstr ESI
~
; ----------------------------------------------------- 
; ЭТАП 2 (50 очков):
; (15 очков) цикл для ввода N дат и сохранения их в массиве Arr_of_Rec:
; решение:
    outstrln 'Введите 6 дат:'
    xor ECx, ECX
inp:lea ESI, Arr_of_Rec[2*ECX]
    push ESI
    call In_Rec
    inc ECX
    cmp ECX, N
    jne inp

; (15 очков) цикл для вывода N дат, хранящихся в массиве Arr_of_Rec
; решение:
    newline
    xor ECX, ECX
    outstrln 'Вывод дат из Arr_of_Rec:'
ou: push Arr_of_Rec[2*ECX]
    call Out_Rec
    newline
    inc ECX
    cmp ECX, N
    jne ou

; (20 очков) цикл для проверки упорядочены ли элементы-даты по возрастанию
; решение:
    newline
    xor AL, AL
    mov ECX, 1
    lea ESI, ans
L1: lea EDI, Arr_of_Rec[2*ECX]
    mov DI, [EDI]
    movzx EDI, DI
    push EDI
    lea EDI, Arr_of_Rec[2*ECX-2]
    mov DI, [EDI]
    movzx EDI, DI
    push EDI
    call Less
    cmp AL, 0
    je bad
    inc ECX
    cmp ECX, N
    jne L1
    
    lea ESI, ans+3
bad:outstrln ESI
    newline
    

; ----------------------------------------------------- 
; ЭТАП 3 (40 очков):
; применение функции Min_Date для поиска наименьшей даты в массиве Arr_of_Rec
; решение:
    push N
    push offset Arr_of_Rec
    call Min_Date

; вывод наименьшей даты в виде "dd.mm.yy is minimum"
; решение:
    movzx EAX, AX
    push EAX
    call Out_Rec
    outstrln ' is minimum'
    newline

; ----------------------------------------------------- 
; ЭТАП 4 (60 очков):
; (30 очков) цикл движения по массиву Arr_of_Rec с целью распаковки дат 
; и сохранения их в массиве структур  Arr_of_Struc
; решение:
    xor ECX, ECX
L2: movzx EAX, Arr_of_Rec[2*ECX]
    push EAX
    lea EAX, Arr_of_Struc[2*ECX+ECX]
    push EAX
    call Rec_to_Struc
    inc ECX
    cmp ECX, N
    jne L2

; (30 очков) цикл движения по массиву Arr_of_Struc с целью вывода дат 
; на экран (каждую дату - в формате dd.mm.yy)
; решение
    xor ECX, ECX
    outstrln 'Структуры: '
L3: lea EAX, Arr_of_Struc[2*ECX+ECX]
    push EAX
    call Out_Struc
    inc ECX
    cmp ECX, N
    jne L3

; ----------------------------------------------------- 
	
	pause
	exit
	end start
	
ТЕСТЫ, на которых надо сдавать программу:
---------------------------------------------------------
ЭТАП 1
---------------------------------------------------------
1)  10.2.20 13.2.20	   ===>   10.2.20<13.2.20 is true
2)  20.2.20 10.3.20	   ===>   20.2.20<10.3.20 is true  
3)  15.2.20 10.2.21	   ===>   15.2.20<10.2.21 is true  
4)  1.2.3 1.2.3	       ===>   1.2.3<1.2.3 is false
5)  10.2.20 15.1.20	   ===>   10.2.20<15.1.20 is false
6)  9.2.20 10.2.19	   ===>   9.2.20<10.2.19 is false
---------------------------------------------------------
ЭТАП 2
---------------------------------------------------------
1)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 15.4.20	===> sorted
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.2	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
---------------------------------------------------------
ЭТАП 3
---------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
---------------------------------------------------------
