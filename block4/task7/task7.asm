include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_7 (����_4) '������������� � ������������� �����' ",0

.code
    Reverse proc
        push ECX
        
        inint ECX
        cmp ECX, 0
        je @F
        jG @pol
        jL @otr
        
@pol:   call Reverse
        outint ECX
        outchar ' '
        jmp @F
        
@otr:   outint ECX
        outchar ' '
        call Reverse
        
@@:     pop ECX
        ret
    Reverse endp
    
    Start:
        ConsoleTitle offset T
        outstrln '������� ����-����� �����:'
        call Reverse
        newline
        
        pause
        exit
    end Start
