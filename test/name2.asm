include console.inc

.data
N = 5
X dw 3, 10, 6, 1, 6
.code
    F proc
        push EBP
        mov EBP, ESP
        sub ESP, 4
        push EBX
        push ECX
        PUSH EDX
        push EDi
        push ESI

        mov ESI, [EBP+8]
        mov ECX, [EBP+12]
        mov BX, [ESI+2*ECX-4]
        mov DI, 5

@L:     mov AX, [ESI+2*ECX-2]
        sub AX, BX
        cwd
        idiv DI
        cmp DX, 0
        jne @next
        mov [EBP-4], ECX
        dec dword ptr [EBP-4]
@next:  loop @L

        mov EAX, [EBP-4]

        pop ESI
        pop EDI
        POP EDX
        POP ECX
        POP EBX
        MOV ESP, EBP
        POP EBP
        ret 4*2
    F endp
    Start:
    
        push N
        push offset X
        call F
        outword EAX
        
        pause
        exit
    end Start
