include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_3 (блок_4) 'Переворот порядка слов' ",0
N   equ 100
S   db N dup(?)
.code
    Back proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        push EDX
        push EDI
        push ESI
        
        mov EAX, [EBP+8]    ;begin
        mov EBX, [EBP+12]   ;end
        
        cmp EAX, EBX
        je @end
        
        mov ECX, EAX
@L1:    push [ECX]
        inc ECX
        cmp ECX, EBX
        jbe @L1
        
        mov ECX, EAX
@L2:    pop EDX
        mov [ECX], DL
        inc ECX
        cmp ECX, EBX
        jbe @L2
        
        mov ECX, EAX
@L3:    mov DL, [ECX]
        cmp DL, ' '
        jne @F
        inc ECX
        cmp ECX, EBX
        jb @L3
        jmp @end
        
@@:     mov ESI, ECX
@L4:    inc ESI
        cmp ESI, EBX
        ja @F
        mov DL, [ESI]
        cmp DL, ' '
        je @F
        jmp @L4
        
@@:     mov EDX, ECX
        mov EDI, ESI
        dec ESI
@L5:    push [EDX]
        inc EDX
        cmp EDX, ESI
        jbe @L5
        
@L6:    pop EDX
        mov [ECX], DL
        inc ECX
        cmp ECX, ESI
        jbe @L6
        
        mov ECX, EDI
        cmp ECX, EBX
        jb @L3
        
        
@end:   pop ESI
        pop EDI
        pop EDX
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4*2
    Back endp
    
    Start:
        ConsoleTitle offset T
        outstrln'Введите текст, в конце точка: '
        xor ECX, ECX
input:  inchar AL
        cmp AL, '.'
        je endin
        mov S[ECX], AL
        inc ECX
        cmp ECX, N
        jb input
        
endin:  lea EBX, S[ECX-1]
        lea EAX, S
        mov byte ptr [EBX+1], 0
        
        push EBX
        push EAX
        call Back
        
        outstrln EAX
        pause 'Нажмите любую клавишу...'
        exit
    end Start
