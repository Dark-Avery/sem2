include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_3 (����� 1) ",0       ; ���������� � �������� ������

.code
    Start:

        ConsoleTitle offset T
        inchar AL
        cmp AL, '0'
        je zero
        jb fin
        cmp AL, '9'
        ja fin
        mov ECX, 1
        
L:      inchar AL
        cmp AL, 'h'
        je kon
        cmp AL, 'A'
        jne fin
        cmp AL, 'a'
        j
        inc ECX
        
        pause
        exit
    end Start
