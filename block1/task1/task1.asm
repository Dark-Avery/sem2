include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_1 (����_1) '������� ������' ",0
    

.code
    Start:
        ConsoleTitle offset T 
        
        inint EAX, '������� �����: '
        mov EDX, 0
        mov CL, 0
        mov EBX, 3
        
L:      cmp EAX, 1
        je fin
        div EBX
        cmp EDX, 0
        jne er
        inc CL
        jmp L
        
er:     mov CL, -1

fin:    outintln CL,,"����� "
        
        pause               
        exit                
    end Start
