include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_6 (����_4) '����� ��������' ",0

.code
    Reverse proc
        push ECX
        
        inchar CL
        cmp CL, '.'
        je @F
        
        call Reverse
        outchar CL
        
@@:     pop ECX
        ret
    Reverse endp
    
    Start:
        ConsoleTitle offset T
        outstrln '������� �����:'
        call Reverse
        newline
        
        pause
        exit
    end Start
