include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_5 (����_4) '������������ ����� � ���������� ������ �����' ",0

.code
    MaxDig proc
        push EBP
        mov EBP, ESP
        push EBX
        push ECX
        push EDX
        
        mov EAX, [EBP+8]
        mov EBX, 10
        xor EDX, EDX
        cmp EAX, EBX
        jb @F
        
        div EBX
        push EAX
        call MaxDig
        
        cmp EAX, EDX
        jae @F
        mov EAX, EDX
        
@@:     pop EDX
        pop ECX
        pop EBX
        pop EBP
        ret 4
    MaxDig endp
        
    Start:
        ConsoleTitle offset T
        inint EBX,'������� N: '
        push EBX
        call MaxDig
        outwordln EAX,,'������������ ����� � ������ ����� - '
        
        pause
        exit
    end Start
