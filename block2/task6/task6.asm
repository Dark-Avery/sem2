include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_6 (����_2) '���������� �������' ",0       ; ���������� � �������� ������
N   equ 30
X   dd N dup(?)
.code
    Start:

        ConsoleTitle offset T
        inint EDI,'������� ���������� ��������� �������: '
        
        mov ECX, EDI
        outstrln '������� �������� �������: '
input:  inint X[4*ECX-4]
        loop input       
        
        mov ECX, EDI
L:      mov EBP, ECX
        mov EDX, X
        mov EAX, 0
        
Li:     cmp X[4*ECX-4], EDX
        jLE next
        mov EAX, ECX
        dec EAX
        mov EDX, X[4*ECX-4]
next:   loop Li
        
        mov ECX, EBP
        mov EBX, X[4*ECX-4]
        mov X[4*EAX], EBX
        mov X[4*ECX-4], EDX
        loop L
        
        mov ESI, 0
output: outint X[4*ESI]
        outchar ' '
        inc ESI
        cmp ESI, EDI
        jne output
        
        pause
        exit
    end Start
