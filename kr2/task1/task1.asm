include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_1 (�����_2 ���) '������ ������' ",0       ; ���������� � �������� ������
S   db 'No',0,'Yes',0
.code
    Start:
        lea EDI, [ESP]
        ConsoleTitle offset T
        lea ESI, S
        mov EAX, 0
        mov EDX, 0
        
L:      inchar AL
        cmp AL, '.'
        je fin
        cmp AL, '('
        je open
        cmp AL, '['
        je open
        cmp AL, ')'
        je ckr
        cmp AL, ']'
        je ckv
        jmp L
        
open:   push EAX
        jmp L
        
ckr:    pop EDX
        cmp DL, '('
        jne output
        jmp L
        
ckv:    pop EDX
        cmp DL, '['
        jne output
        jmp L
        
fin:    cmp EDI, ESP
        jne output
        lea ESI, S+3
        
output: outstrln ESI
        lea ESP, [EDI]
        
        pause
        exit
    end Start
