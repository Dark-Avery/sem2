include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_6 (����_1) '���������� �����' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        inchar BL, '������� ����� � ���������� ������� ���������: '
        mov ECX, 0
        mov ESI, 5
        
L:      mov EAX, ECX
        mul ESI
        mov ECX, EAX
        sub BL, '0'
        movzx EBX, BL
        add ECX, EBX
        inchar BL
        cmp BL, ' '
        je fin
        jmp L
        
fin:    outwordln ECX,,'� ����������: '
        
        pause
        exit
    end Start
