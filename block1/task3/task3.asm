include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_3 (����_1) '������ ������' ",0
S   db '���',0,'��',0

.code
    Start:
        Cls
        ConsoleTitle offset T 
        
        lea ESI, S
        mov EAX, 0
        inchar CL, '������� ������������������: '
        outstr '������ ������ - '
        
L:      cmp CL, '.'
        je fin
        cmp CL, '('
        je open
        cmp CL, ')'
        je close
        
check:  cmp EAX, 0
        jL outp
        inchar CL
        jmp L
        
open:   inc EAX
        jmp check
        
close:  dec EAx
        jmp check
        
fin:    cmp EAX, 0
        jne outp
        lea ESI, S+4
        
outp:   outstrln ESI
        
        pause               
        exit                
    end Start
