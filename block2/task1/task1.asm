include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_1 (����_2) '������ ���������' ",0       ; ���������� � �������� ������
LAT db 'Z'-'A'+1 dup(0)
.code
    Start:

        ConsoleTitle offset T
        
        mov EAX, 0
        outstr '������� �����: '
L:      inchar AL
        cmp AL,'.'
        je fin
        cmp LAT[EAX-'A'],1
        je L
        mov LAT[EAX-'A'],1
        outchar AL
        jmp L
        
        
fin:    pause
        exit
    end Start
