include console.inc

; ОПИСАНИЕ ТИПОВ (ЗАПИСИ) И (СТРУКТУРЫ):
Date_pack record D:5, M:4, Y:7
Date_unpack struc  ; дата в рамках некоторого столетия
D   db ?           ; день (от 1 до 31)
M   db ?           ; месяц (от 1 до 12)
Y   db ?           ; год (от 0 до 99)
Date_unpack ends

; ОПИСАНИЕ ПРОЦЕДУР: 
.code
; -----------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; действие: ввод значений полей D, M, Y записи типа Date_pack
In_Rec proc public
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
Less proc public
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
Out_Rec proc public
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
Min_Date proc public
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
Rec_to_Struc proc public
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
Out_Struc proc public
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
Ptr_to_Min_Date proc
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
    lea EDI, [EBX]
    dec ECX
    
    jecxz @ez
@L: movzx EDX, DX
    movzx ESI, word ptr [EBX][2*ECX]
    push ESI
    push EDX
    call Less
    cmp AL, 1
    je @F
    mov DX, [EBX][2*ECX]
    lea EDI, [EBX][2*ECX]
    
@@: dec ECX
    jnz @L
    
@ez:mov EAX, EDI
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Ptr_to_Min_Date endp
    
    
; -----------------------------------------------------
Sort proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, [EBP+8]
    mov EBX, [EBP+12]
    
    xor ECX, ECX
    
@L: mov EDX, EBX
    sub EDX, ECX
    push EDX
    lea EDI, [ESI+2*ECX]
    push EDI
    call Ptr_to_Min_Date
    mov DI, [EAX]
    mov DX, [ESI+2*ECX]
    mov [EAX], DX
    mov [ESI+2*ECX], DI
    inc ECX
    cmp ECX, EBX
    jne @L
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Sort endp
; -----------------------------------------------------    
Out_Sort proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
    xor ECX, ECX
@L: push [EAX+2*ECX]
    call Out_Rec
    newline
    inc ECX
    cmp ECX, EBX
    jne @L
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Out_Sort endp

end
