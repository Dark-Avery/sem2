include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_3 (����_2) '��������' ",0       ; ���������� � �������� ������
S   db 20 dup('-'),0
.code
    Start:
        
        ConsoleTitle offset T
        inint ECX,'������� ����� �� 0 �� 20: '
        mov S[ECX],0
        mov EBX, ECX
        lea EDX, S
        

L:      dec EBX
        mov S[EBX], '*'
        outstrln EDX
        dec ECX
        cmp ECX, 0
        jg L
        
fin:    pause
        exit
    end Start
