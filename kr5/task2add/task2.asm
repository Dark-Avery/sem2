include console.inc

.data

.code
    Start:
        mov EAX, 1
        xor ECX, ECX
        
L:      shl EAX, 1
        inc ECX
        cmp EAX, 100000000
        jb L
        
        mov EBX, 100
        xor EDX, EDX
        div EBX
        outword EAX,,'��������� - '
        outword ECX,,' �� '
        outstrln ' ����'

        
        pause
        exit
    end Start
