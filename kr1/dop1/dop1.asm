include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_1 (����� 1) ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        mov ECX, 256
        mov EBX, 10
        
L:      mov EAX, ECX    ;������������ ��������� �����
        mov EDX, 0      ;������� ����� ���������� �
        div EBX         ;������� � ����� ����� ��� �������� �������
        cmp EDX, 255    ;��� ����� 2^8 - 1
        ja fin
        cmp EAX, 255
        ja fin
        inc ECX
        mov ESI, EAX
        mov EDI, EDX
        jmp L
        
fin:    dec ECX
        outwordln ECX,,'�����: '
        outwordln ESI,,'����� �����: '
        outwordln EDI,,'�������: '
        
        pause
        exit
    end Start
