include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_5 (����_2) '����������� 16-� �����' ",0       ; ���������� � �������� ������
dig db 8 dup('0'),0
hx  db '0123456789ABCDEF',0
.code
    Start:

        ConsoleTitle offset T
        inint EAX,'������� ����� �� ��������� [-2147483648, 4294967295]: '
        mov ECX, 8
        mov EBX, 16
        
L:      mov EDX, 0
        div EBX
        mov DL, hx[EDX]
        mov dig[ECX-1], DL
        cmp EAX, 0
        loopne L
        
        lea EDI, dig
        outstr EDI
        
        pause
        exit
    end Start