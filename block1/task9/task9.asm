include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_9 (����_1) '������ � ��������� �����' ",0       ; ���������� � �������� ������

.code
    Start:
        ConsoleTitle offset T
        mov ESI, 0
        inchar AL,'������� ����� ����� �������: '
        
outo:   mov BL, AL
        mov CL, AL
        inchar AL
        
ino:    cmp AL, '.'
        je exitc
        cmp AL, ','
        je exitc
        mov CL, AL
        inchar AL
        jmp ino
        
exitc:  cmp BL, CL
        jne bword
        inc ESI
        
bword:  cmp AL, '.'
        je fin
        inchar AL
        jmp outo
        
fin:    outintln ESI,,'�����: '
        
        pause
        exit
    end Start
