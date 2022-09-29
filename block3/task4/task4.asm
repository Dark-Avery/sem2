include console.inc

.data
T   db " �������� ����� (������ 110)     "   ; ���������� �� ������ ���������
    db " ������_4 (����_3) '�������' ",0       ; ���������� � �������� ������

.code
    Start:
        outintln ESP,,'ESP = '
        newline
        mov EDI, ESP
        ConsoleTitle offset T
        inint EAX, '������� ������ ����� (� ����� 0): '
        mov EBX, 1
        push EBX        ;����� ����
        push EAX        ;������ ����
            
L:      inint EAX
        cmp EAX, 0      ;����� �����
        je choice
        inc EBX
        push EBX        ;���� ����� ����
        push EAX        ;���� ������ ����
        jmp L
        
choice: flush           ;������� ������
        newline
        outstrln 'a - ������ ������, b - ����� ������� (���������)'
Lc:     outstr '����� ������� ������ �������? a/b: '
        inchar AL
        cmp AL,'a'
        je gotoa
        cmp AL,'b'
        je gotob
        jmp Lc
        
gotoa:  mov ECX, 0      ;��������� �������� ������ ����
La:     pop EAX         ;����������� ���� �� ����� (������ ������)
        pop EBX
        cmp EAX, ECX
        jLe nexta       ;���� ��� ������ ����, �� ������� ��� � ������ ����
        outint EAX
        outintln EBX,,':'
        mov ECX, EAX
nexta:  cmp EDI, ESP    ;��������� ����� ���� ����
        jne La
        jmp fin
      
;gotob:  mov ECX, 0      ;������ �� �� �����, ��� � � ������ �
;                        ;�� ������ ������ �������� � ���� "����"
;        mov ESI, ESP    
;        sub ESI, 1000   ;��������� ����� �� ESP �������, �����
;        mov EDX, ESI    ;������������ ������ �� ������ ���� ��������
;Lb1:    pop EAX
;        pop EBX
;        cmp EAX, ECX
;        jLe nextb
;        sub ESI, 4
;        mov [ESI], EBX
;        sub ESI, 4
;        mov [ESI], EAX
;        mov ECX, EAX
;nextb:  cmp EDI, ESP
;        jne Lb1

gotob:  mov ECX, 0       
        mov ESI, ESP    
        mov EDX, ESP
Lb1:    mov EAX, [ESI]
        add ESI, 4
        mov EBX, [ESI]
        add ESI, 4
        cmp EAX, ECX
        jLe nextb
        push EBX
        push EAX
        mov ECX, EAX
nextb:  cmp EDI, ESI
        jne Lb1
        
Lb2:    pop EAX
        pop EBX
        outint EAX
        outintln EBX,,':'
        cmp ESP, EDX
        jne Lb2
        
;Lb2:    mov EAX, [ESI]  ;� ����� ������ ������� �� "�����" ������������ �����
;        add ESI, 4
;        mov EBX, [ESI]
;        add ESI, 4
;        outint EAX
;        outintln EBX,,':'
;        cmp ESI, EDX    ;��������� ����� "����" ����
;        jne Lb2
        
fin:    newline
        mov ESP, EDI
        outintln ESP,,'ESP = '
        pause
        exit
    end Start
