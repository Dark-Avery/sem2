include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_1 (����_3) '�������������� �����' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        outstr '������� �������: '
        mov EAX, 0
        
L:      inchar AL
        cmp AL, '.'
        je fin
        cmp AL, ')'
        je calc
        cmp AL, '('
        je L
        cmp AL, '+'
        jne @F
        push EAX
        jmp L
@@:     cmp AL, '-'
        jne @F
        push EAX
        jmp L
@@:     sub EAX, '0'
        push EAX
        jmp L
        
calc:   pop EBX
        pop ECX
        pop EDX
        cmp ECX, '+'
        je plus
        sub EDX, EBX
        push EDX
        jmp L
plus:   add EDX, EBX
        push EDX
        jmp L
        
fin:    pop EAX
        outint EAX,,'����� = '
        
        pause
        exit
    end Start
