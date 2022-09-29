include console.inc

In_Rec proto 
Less proto 
Out_Rec proto 
Min_Date proto 
Rec_to_Struc proto 
Out_Struc proto 
Sort proto 
Out_Sort proto 

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
T   db " �������� �����   ����_6 (�����-4)",0	;	
N   equ 6
D1  Date_pack <>                    ; ����������� ����_1
D2  Date_pack <>                    ; ����������� ����_2
Arr_of_Rec Date_pack N dup (<>)     ; ������ ������� (����������� ���)
Arr_of_Struc Date_unpack N dup (<>) ; ������ �������� (������������� ���)
tr  db 'true',0
fls db 'false',0
ans db '�� ���������� ������ �� �����������',0

.code
start:	
    ConsoleTitle offset T	
; ----------------------------------------------------- 
; ���� 1 (40 �����):
; (10 �����) ���� ���� ��� D1 � D2 (������ � ������� dd.mm.yy)
; �������:
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
@@: newline
    push D1
    call Out_Rec
    outchar ' '
    outchar 60
    outchar ' '
    push D2
    call Out_Rec
    outstr ' is '
    outstrln ESI
    newline
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
; ���� 5
    push N
    push offset Arr_of_Rec
    call Sort
    newline
    outstrln '��������������� ������:'
    push N
    push offset Arr_of_Rec
    call Out_Sort
	
	
	newline
	pause '������� ����� �������...'
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
