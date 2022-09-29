include console.inc

extern A: dword, B: dword, Z: qword
public comul

.code
comul:  mov EAX, A
        mov EBX, B
        xor EDX, EDX
        
        mul EBX
        mov dword ptr Z, EAX
        mov dword ptr Z+4, EDX
        outword A
        outchar '*'
        outword B
        outchar '='
        outwordln Z
                
        pause 'Нажмите любую клавишу...'
        exit
    end
