include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_2 (����� 1)",0       ; ���������� � �������� ������
Y   dd ?
S   db '����������',0,'�� ����������',0
.code
    Start:

        ConsoleTitle offset T
        lea ESI, S+11
        inint Y,'������� ��� '
        mov EAX, Y
        mov EDX, 0
        mov EBX, 4
        div EBX
        cmp EDX, 0
        jne outp
        mov EAX, Y
        mov EDX, 0
        mov EBX, 100
        div EBX
        cmp EDX, 0
        jne fin
        mov EAX, Y
        mov EDX, 0
        mov EBX, 400
        div EBX
        cmp EDX, 0
        jne outp
        jmp fin
        
fin:    lea ESI, S
        
outp:   outstr ESI
        
        pause
        exit
    end Start
