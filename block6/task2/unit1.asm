include console.inc

.code
    Mult proc public
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]
        mov EBX, [EBP+12]
        mov EDX, [EBP+16]
        
        xor EDI, EDI
        xor ESI, ESI
        mov ECX, 32
@ncmul: shl ESI, 1
        rcl EDI, 1
        shl EBX, 1
        jnc @F
        add ESI, EAX
        adc EDI, 0
@@:     loop @ncmul
        
        mov [EDX], ESI
        mov [EDX+4], EDI
        
        pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4*3
    Mult endp
    end
