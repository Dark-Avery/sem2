include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_9 (����_4) '�������� � �������' ",0

.code
    MaxMin proc
        push EBX
        
        inchar BL
        cmp BL, 'M'
        je @max
        cmp BL, 'm'
        je @min
        
        sub BL, '0'
        mov AL, BL
        jmp @fin
        
@max:   inchar BL
        call MaxMin
        inchar BL
        mov BL, AL
        call MaxMin
        cmp AL, BL
        ja @F
        xchg AL, BL
@@:     inchar BL
        jmp @fin
        
@min:   inchar BL
        call MaxMin
        inchar BL
        mov BL, AL
        call MaxMin
        cmp AL, BL
        jb @F
        xchg AL, BL
@@:     inchar BL
        jmp @fin
        
@fin:   pop EBX
        ret
    MaxMin endp
        
    Start:
        ConsoleTitle offset T
        outstr '������� ������� ���� M/m(*,*): '
        call MaxMin
        outint AL,,'����� - '
        
        pause
        exit
    end Start
