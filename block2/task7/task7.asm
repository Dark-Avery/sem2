include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_7 (����_2) '���������� ���������' ",0       ; ���������� � �������� ������
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
        mov EAX, 1
        mov ESI, '0'
        
Li:     mov EDX, X[4*EAX-4]
        cmp EDX, X[4*EAX]
        jLE next
        mov ESI, X[4*EAX]
        mov X[4*EAX], EDX
        mov X[4*EAX-4], ESI
next:   inc EAX
        cmp EAX, ECX
        jb Li
        
        mov ECX, EBP
        cmp ESI, '0'
        je fin
        loop L
        
fin:    mov ESI, 0
output: outint X[4*ESI]
        outchar ' '
        inc ESI
        cmp ESI, EDI
        jne output
        
        pause
        exit
    end Start
