include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_5 (����_1) '������������ ������� � ������� ���������� ����' ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        inint EAX, '������� �����: '
        mov EBX, 10
        mov EDX, 0
        div EBX
        mov ECX, EDX
        cmp EAX, 0
        je one
        
L:      cmp EAx, EBX
        jb fin
        mov EDX, 0
        div EBX
        jmp L
        
one:    xchg EAX, EDX
        
fin:    outint EAX
        outstr ' * '
        outint ECX
        mul ECX
        outintln EAX,,' = '
        
        pause
        exit
    end Start
