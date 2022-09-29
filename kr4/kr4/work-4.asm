include console.inc
; (����� ��� ������ 1,2,3 -  � ����� ���� ���������)
; �������� ����� (������) � (���������):
; ��������, ������ ������� ��������� � �������� ����� � ����������: 
Date_pack record D:5, M:4, Y:7
Date_unpack struc  ; ���� � ������ ���������� ��������
D   db ?           ; ���� (�� 1 �� 31)
M   db ?           ; ����� (�� 1 �� 12)
Y   db ?           ; ��� (�� 0 �� 99)
Date_unpack ends

; �������� ����������:
.data
T   db " �������� �����   ����_1 (�����-4)",0	;	
N   equ 6
D1  Date_pack <>                    ; ����������� ����_1
D2  Date_pack <>                    ; ����������� ����_2
Arr_of_Rec Date_pack N dup (<>)     ; ������ ������� (����������� ���)
Arr_of_Struc Date_unpack N dup (<>) ; ������ �������� (������������� ���)
tr  db 'true',0
fls db 'false',0
ans db '�� ���������� ������ �� �����������',0
; �������� ��������: 
.code
; -----------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; ��������: ���� �������� ����� D, M, Y ������ ���� Date_pack
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
; AL := 1 (���� D1<D2, �.�. ���� ����_1 ������������ ����_2)
; AL := 0 (�����)
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
; ��������: ����� �������� ����� D, M, Y ������ ���� Date_pack
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
; ��������: �� := ����������� ���� ����� ���������-��� ������� Arr
; (����������� - �������������� ���� ��������� �����)
; ������� Min_Date � �������� ����� ������ ��� ��������� �������� �������� 
; � ��������� ����� ���������� � ����� ���������� ������� Less(D1,D2)
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
; procedure Rec_to_Stru�(D_pack: Date_pack; var D_unpack: Date_unpack)
; ��������: ���������� ���� 
; (�� ������ ���� Date_pack � ��������� ���� Date_unpack)
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
; ��������: ����� �������� ����� D, M, Y ��������� ���� Date_unpack
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
; ������� ����� (�������� ���������):
start:	
    ConsoleTitle offset T	
; ----------------------------------------------------- 
; ���� 1 (40 �����):
; (10 �����) ���� ���� ��� D1 � D2 (������ � ������� dd.mm.yy)
; �������:
comment ~
    outstrln '1st data'
    push offset D1
    call In_Rec
    outstrln '2nd data'
    push offset D2
    call In_Rec
; (20 �����) ��������� ���� ��� (D1 < D2 ?)
; �������:
    movzx EBX, D2
    movzx ECX, D1
    push EBX
    push ECX
    call Less
    lea ESI, fls
    cmp AL, 0
    je @F
    lea ESI, tr
; (10 �����) ����� ���������� ��������� � ���� "D1<D2 is true/false",
; ��� ������ D1 � D2 ������ ���� ���������� ���� � ������� dd.mm.yy
; �������:
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
; ���� 2 (50 �����):
; (15 �����) ���� ��� ����� N ��� � ���������� �� � ������� Arr_of_Rec:
; �������:
    outstrln '������� 6 ���:'
    xor ECx, ECX
inp:lea ESI, Arr_of_Rec[2*ECX]
    push ESI
    call In_Rec
    inc ECX
    cmp ECX, N
    jne inp

; (15 �����) ���� ��� ������ N ���, ���������� � ������� Arr_of_Rec
; �������:
    newline
    xor ECX, ECX
    outstrln '����� ��� �� Arr_of_Rec:'
ou: push Arr_of_Rec[2*ECX]
    call Out_Rec
    newline
    inc ECX
    cmp ECX, N
    jne ou

; (20 �����) ���� ��� �������� ����������� �� ��������-���� �� �����������
; �������:
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
; ���� 3 (40 �����):
; ���������� ������� Min_Date ��� ������ ���������� ���� � ������� Arr_of_Rec
; �������:
    push N
    push offset Arr_of_Rec
    call Min_Date

; ����� ���������� ���� � ���� "dd.mm.yy is minimum"
; �������:
    movzx EAX, AX
    push EAX
    call Out_Rec
    outstrln ' is minimum'
    newline

; ----------------------------------------------------- 
; ���� 4 (60 �����):
; (30 �����) ���� �������� �� ������� Arr_of_Rec � ����� ���������� ��� 
; � ���������� �� � ������� ��������  Arr_of_Struc
; �������:
    xor ECX, ECX
L2: movzx EAX, Arr_of_Rec[2*ECX]
    push EAX
    lea EAX, Arr_of_Struc[2*ECX+ECX]
    push EAX
    call Rec_to_Struc
    inc ECX
    cmp ECX, N
    jne L2

; (30 �����) ���� �������� �� ������� Arr_of_Struc � ����� ������ ��� 
; �� ����� (������ ���� - � ������� dd.mm.yy)
; �������
    xor ECX, ECX
    outstrln '���������: '
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
	
�����, �� ������� ���� ������� ���������:
---------------------------------------------------------
���� 1
---------------------------------------------------------
1)  10.2.20 13.2.20	   ===>   10.2.20<13.2.20 is true
2)  20.2.20 10.3.20	   ===>   20.2.20<10.3.20 is true  
3)  15.2.20 10.2.21	   ===>   15.2.20<10.2.21 is true  
4)  1.2.3 1.2.3	       ===>   1.2.3<1.2.3 is false
5)  10.2.20 15.1.20	   ===>   10.2.20<15.1.20 is false
6)  9.2.20 10.2.19	   ===>   9.2.20<10.2.19 is false
---------------------------------------------------------
���� 2
---------------------------------------------------------
1)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 15.4.20	===> sorted
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.2	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
---------------------------------------------------------
���� 3
---------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
---------------------------------------------------------
