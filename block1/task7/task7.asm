include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_7 (����_1) '��������� �����, ������� ����' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        inint ECX,'������� �����: '
        mov EDX, 0
        mov EAX, ECX
        mov ESI, 7
        
        div ESI
        sub ECX, EDX
        cmp EDX, 3
        ja great
        jmp fin
        
great:  add ECX, 7

fin:    outwordln ECX,,'��������� ������� 7: '
        
        pause
        exit
    end Start
