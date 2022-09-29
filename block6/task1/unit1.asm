include console.inc

public In4, Out4

.code
    In4 proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        
        mov EBX, [EBP+8]
        
        xor EAX, EAX
@in:    inchar CL
        cmp CL, ' '
        je @F
        sub CL, '0'
        shl EAX, 2
        or AL, CL
        jmp @in
        
@@:     mov [EBX], EAX
        
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4
    In4 endp
    
    Out4 proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        
        mov EAX, [EBP+8]
        
        mov ECX, 16
@out:   rol EAX, 2
        mov EBX, EAX
        and EBX, 11b
        outword EBX
        loop @out
        newline
        
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4
    Out4 endp
    
    end
