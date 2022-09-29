include console.inc
.data
N equ 6
Date_pack record D:5, M:4, Y:7
D1 Date_pack <>
D2 Date_pack <>
Arr_of_Rec Date_pack N dup(<>)
truestr db 'истинно', 0
falsstr db 'ложно', 0
Date_unpack struc
    D db ?
    M db ?
    Y db ?
Date_unpack ends
Arr_of_Struc Date_unpack N dup(<>)
.code
    InRec Proc
        push EBP
        mov EBP, ESP
        push EBX
        push EDX
        push EDI

        mov EBX, [EBP + 8];       parameter offset
        inint DX
        shl DX, D
        inint DI
        shl DI, M
        or DX, DI
        inint DI
        or DX, DI
        mov [EBX], DX

        pop EDI
        pop EDX
        pop EBX
        pop EBP
        ret 4
    InRec endp

    Less Proc
        push EBP
        mov EBP, ESP
        push EBX
        push EDX
        push EDI
        push ESI

        xor AL, AL
        mov DX, [EBP + 12];      1st var
        mov BX, [EBP + 8];       2nd var

        mov DI, mask Y
        and DI, DX
        mov SI, mask Y
        and SI, BX
        cmp DI, SI
        jb @good
        ja @bad

        mov DI, mask M
        and DI, DX
        mov SI, mask M
        and SI, BX
        cmp DI, SI
        jb @good
        ja @bad

        mov DI, mask D
        and DI, DX
        mov SI, mask D
        and SI, BX
        cmp DI, SI
        jae @bad

@good:  inc AL
@bad:   pop ESI
        pop EDI
        pop EDX
        pop EBX
        pop EBP
    ret 4*2
    Less endp

    Out_Rec Proc
        push EBP
        mov EBP, ESP
        push EBX
        push EDX

        mov EBX, [EBP + 8]

        mov DX, mask D
        and DX, BX
        shr DX, D
        outword DX
        outchar '.'

        mov DX, mask M
        and DX, BX
        shr DX, M
        outword DX
        outchar '.'

        mov DX, mask Y
        and DX, BX
        outword DX

        pop EDX
        pop EBX
        pop EBP
    ret 4
    Out_Rec endp

    Min_Date Proc
        push EBP
        mov EBP, ESP
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI

        mov ECX, [EBP + 12];      Array Length
        mov EBX, [EBP + 8];       Array Offset

        mov DX, [EBX];            Assume 1st elem is the smallest
        sub ECX, 1

@cyc:   movzx EDI, DX
        movzx ESI, word ptr [EBX][2*ECX]
        push EDI
        push ESI
        call Less
        cmp AL, 1
        je @nextst
        mov DX, [EBX][2*ECX]

@nextst:dec ECX
        jnz @cyc

        mov AX, DX
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        mov ESP, EBP
        pop EBP
    ret 4*2
    Min_Date endp

    Rec_To_Struc Proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI

        mov DI, [EBP + 12];       packed value, extended to 32-bit
        mov ESI, [EBP + 8];       unpacked offset

        mov AX, mask D
        and AX, DI
        shr AX, D
        ;AL(AX) now contains Day values
        mov BX, mask M
        and BX, DI
        shr BX, M
        ;BL(BX) now contains Month values
        mov CX, mask Y
        and CX, DI
        ;CL(CX) now contains Year values

        mov (Date_unpack ptr [ESI]).D, AL
        mov (Date_unpack ptr [ESI]).M, BL
        mov (Date_unpack ptr [ESI]).Y, CL

        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
    ret 4*2
    Rec_To_Struc endp

    Out_Struc Proc
        push EBP
        mov EBP, ESP
        push ESI

        mov ESI, [EBP + 8];       data offset

        outword (Date_unpack ptr [ESI]).D
        outchar '.'
        outword (Date_unpack ptr [ESI]).M
        outchar '.'
        outwordln (Date_unpack ptr [ESI]).Y

        pop ESI
        pop EBP
    ret 4*1
    Out_Struc endp

    Ptr_to_Min_Date Proc
        push EBP
        mov EBP, ESP
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI

        mov ECX, dword ptr [EBP + 12];      Array Length
        mov EBX, dword ptr [EBP + 8];       Array Offset

        dec ECX
        movzx EDX, word ptr [EBX];            Assume first elem is the smallest
        lea EDI, [EBX]

@cyc:   cmp ECX, 0
        je @cycfin

        movzx ESI, word ptr [EBX][2*ECX]
        push EDX
        push ESI
        call Less
        cmp AL, 1
        je @nextst
        movzx EDX, word ptr [EBX][2*ECX]
        lea EDI, [EBX][2*ECX]

@nextst:dec ECX
        jmp @cyc

@cycfin:mov EAX, EDI
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        mov ESP, EBP
        pop EBP
    ret 4*2
    Ptr_to_Min_Date endp

    Sort Proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI

        mov ECX, dword ptr [EBP + 12];      Array Length
        mov EBX, dword ptr [EBP + 8];       Array Offset

        xor EDI, EDI;                       Cycle Counter

@cyc:   lea ESI, [EBX][2*EDI]
        mov EDX, ECX
        sub EDX, EDI
        
        push EDX
        push ESI
        call Ptr_to_Min_Date
        
        mov DX, [EBX][2*EDI]
        mov SI, [EAX]
        mov [EAX], DX
        mov [EBX][2*EDI], SI
        inc EDI
        cmp EDI, ECX
        jne @cyc


        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        mov ESP, EBP
        pop EBP
    ret 4*2
    Sort endp


    Start:
        outstrln 'Введите первую дату: '
        push offset D1
        call InRec
        outstrln 'Введите вторую дату: '
        push offset D2
        call InRec
        newline
        movzx EBX, D1
        movzx EDX, D2
        push EBX
        push EDX
        call Less
        push EBX
        call Out_Rec
        push EDX
        outchar ' '
        outchar 60
        outchar ' '
        call Out_Rec
        outchar ' '
        lea EDI, truestr
        cmp AL, 0
        jne @F
        lea EDI, falsstr
@@:     outstrln EDI
        newline

        outstrln 'Введите 6 дат: '
        xor ECX, ECX
incyc:  cmp ECX, N
        je infin
        lea EDI, word ptr Arr_of_Rec[2*ECX]
        push EDI
        call InRec
        inc ECX
        jmp incyc

infin:  newline
        xor ECX, ECX
        outstrln 'Вывод записей'
outcyc: cmp ECX, N
        je outfin
        lea EDI, word ptr Arr_of_Rec[2*ECX]
        mov DI, [EDI]
        movzx EDI, DI
        push EDI
        call Out_Rec
        newline
        inc ECX
        jmp outcyc

outfin: newline

        xor AL, AL
        mov ECX, 1
cmpcyc: cmp ECX, N
        je cmpfin
        lea EDI, word ptr Arr_of_Rec[2*ECX - type Date_pack]
        mov DI, [EDI]
        movzx EDI, DI
        push EDI
        lea ESI, word ptr Arr_of_Rec[2*ECX]
        mov SI, [ESI]
        movzx ESI, SI
        push ESI
        call Less
        cmp AL, 0
        je ns
        inc ECX
        jmp cmpcyc

cmpfin: outstrln 'Упорядочены, конвертируем в структуру'
        jmp step4
ns:     outstrln 'Не упорядочены, поиск минимума'
        newline
        push N
        push offset Arr_of_Rec
        call Min_Date
        movzx EAX, AX
        outstr 'Минимум: '
        push EAX
        call Out_Rec
        newline
        jmp stg5;           terminate


step4:  xor ECX, ECX
cyc4:   movzx EAX, Arr_of_Rec[2*ECX]
        push EAX
        lea EAX, Arr_of_Struc[ECX][2*ECX]
        push EAX
        call Rec_To_Struc
        inc ECX
        cmp ECX, N
        jne cyc4

        xor ECX, ECX
        outstrln 'Вывод структур: '
strou:  lea EAX, Arr_of_Struc[ECX][2*ECX]
        push EAX
        call Out_Struc
        inc ECX
        cmp ECX, N
        jne strou
        jmp term

stg5:   push N
        push offset Arr_of_Rec
        call Sort
        newline

        xor ECX, ECX
        outstrln 'Отсортированный массив: '
oucyc:  lea EDI, word ptr Arr_of_Rec[2*ECX]
        mov DI, [EDI]
        movzx EDI, DI
        push EDI
        call Out_Rec
        newline
        inc ECX
        cmp ECX, N
        jne oucyc

term:   newline
        pause 'Нажмите любую клавишу...'
        exit
    end Start