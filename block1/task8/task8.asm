include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_8 (����_1) '�������������� �����' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        inchar AL,'������� �������������� �����: '
        sub AL, '0'
        movzx ECX, AL
        
L:      inchar AL
        cmp AL, '.'
        je fin
        cmp AL, '+'
        je plus
        cmp AL, '-'
        je minus
        
plus:   inchar AL
        sub AL, '0'
        movzx EAX, AL
        add ECX, EAX
        jmp L
        
minus:  inchar AL
        sub AL, '0'
        movzx EAX, AL
        sub ECX, EAX
        jmp L
        
fin:    outintln ECX,,'�����: '
        
        pause
        exit
    end Start
