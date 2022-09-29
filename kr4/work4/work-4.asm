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
T   db " �������______ ���______    ����_1 (�����-4)",0	;	
N   equ 6
D1  Date_pack <>                    ; ����������� ����_1
D2  Date_pack <>                    ; ����������� ����_2
Arr_of_Rec Date_pack N dup (<>)     ; ������ ������� (����������� ���)
Arr_of_Struc Date_unpack N dup (<>) ; ������ �������� (������������� ���)

; �������� ��������: 
.code
; -----------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; ��������: ���� �������� ����� D, M, Y ������ ���� Date_pack
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
; AL := 1 (���� D1<D2, �.�. ���� ����_1 ������������ ����_2)
; AL := 0 (�����)
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
; ��������: ����� �������� ����� D, M, Y ������ ���� Date_pack
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
; procedure Rec_to_Stru�(D_pack: Date_pack; var D_unpack: Date_unpack)
; ��������: ���������� ���� 
; (�� ������ ���� Date_pack � ��������� ���� Date_unpack)
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
; ��������: ����� �������� ����� D, M, Y ��������� ���� Date_unpack
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
; ������� ����� (�������� ���������):
start:	
    ConsoleTitle offset T	
; ----------------------------------------------------- 
; ���� 1 (40 �����):
; (10 �����) ���� ���� ��� D1 � D2 (������ � ������� dd.mm.yy)
; �������:
COMMENT *
    push offset D1
    call In_Rec
    
    
    push offset D2
    call In_Rec
    
; (20 �����) ��������� ���� ��� (D1 < D2 ?)
; �������:
    movzx EBX, D2
    push EBX
    movzx EBX, D1
    push EBX
    call Less
    
; (10 �����) ����� ���������� ��������� � ���� "D1<D2 is true/false",
; ��� ������ D1 � D2 ������ ���� ���������� ���� � ������� dd.mm.yy
; �������:
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
; ���� 2 (50 �����):
; (15 �����) ���� ��� ����� N ��� � ���������� �� � ������� Arr_of_Rec:
; �������:

    mov ECX, N
    lea EBX, Arr_of_Rec
L1:
    push EBX
    call In_Rec
    add EBX, 2
    loop L1
    
; (15 �����) ���� ��� ������ N ���, ���������� � ������� Arr_of_Rec
; �������:
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
; (20 �����) ���� ��� �������� ����������� �� ��������-���� �� �����������
; �������:
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
; ���� 3 (40 �����):
; ���������� ������� Min_Date ��� ������ ���������� ���� � ������� Arr_of_Rec
; �������:
    
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

    


; ����� ���������� ���� � ���� "dd.mm.yy is minimum"
; �������:


; ----------------------------------------------------- 
; ���� 4 (60 �����):
; (30 �����) ���� �������� �� ������� Arr_of_Rec � ����� ���������� ��� 
; � ���������� �� � ������� ��������  Arr_of_Struc
; �������:

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
    
    outstr '���������� ��������� : '
L5:
    push EAX
    call Out_Struc
    add EAX, 3
    loop L5
    
    


; (30 �����) ���� �������� �� ������� Arr_of_Struc � ����� ������ ��� 
; �� ����� (������ ���� - � ������� dd.mm.yy)
; �������


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
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.20	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
---------------------------------------------------------
���� 3
---------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
---------------------------------------------------------
