include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_2 (����_1) '������� �����' ",0
S   db '���������',0,'�������',0
N   dd ?

.code
    Start:
        ConsoleTitle offset T 
        
        lea ESI, S
        inint N, '������� �����: '
        mov EAX, N
        cmp EAX, 4
        jb fin
        mov EDX, 0
        mov EBX, 2
        div EBX
        mov ECX, EAX
        
L:      mov EAX, N
        mov EDX, 0
        div EBX
        cmp EDX, 0
        je outp
        inc EBX
        cmp EBX, ECX
        jb L
        
fin:    lea ESI, S+10
        
outp:   outstrln ESI
        
        pause               
        exit                
    end Start
