include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_8 (����_4) '���������� ����� ��������' ",0

.code
    GCD proc
        push EBP
        mov EBP, ESP
        push ECX
        
        mov EAX, [EBP+8]
        mov ECX, [EBP+12]
        
        cmp ECX, 0
        je @F
        cmp EAX, 0
        xchg EAX, ECX
        je @F
        
        cmp EAX, ECX
        je @F
        ja @bol
        xchg EAX, ECX
@bol:   sub EAX, ECX   
        push ECX
        push EAX
        call GCD
        
@@:     pop ECX
        pop EBP
        ret 4*2
    GCD endp
    
    Start:
        ConsoleTitle offset T
        inint ECX,'������� 2 �����: '
        inint EBX
        
        push ECX
        push EBX
        call GCD
        outwordln EAX,,'��� = '
        
        pause
        exit
    end Start
