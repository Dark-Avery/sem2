include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_4 (����_1) '����� P/Q' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        outstrln '������� ����� P/Q: '
        inintln EAX, 'P = '
        inintln EBX, 'Q = '
        mov EDX, 0
        div EBX
        mov ESI, 10
        outword EAX,,'�����: '
        outchar '.'
        
        mov ECX, 5        
L:      xchg EAX, EDX
        mov EDX, 0
        mul ESI
        div EBX
        outword EAX
        loop L
        
        pause
        exit
    end Start
