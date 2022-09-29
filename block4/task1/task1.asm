include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_1 (блок_4) 'Частоты вхождений букв' ",0
N   equ 100
S   db N dup(?)
.code
    ReadText proc
        push EBP
        mov EBP, ESP
        
        push EBX
        push ECX
        
        mov EAX, 0
        mov ECX, [EBP+8]
        
        outstr 'Введите текст: '
@L:     inchar BL
        cmp BL, '.'
        je @fin
        inc EAX
        mov [ECX], BL
        inc ECX
        jmp @L
        
@fin:   pop ECX
        pop EBX
        pop EBP
        ret 4
    ReadText endp
    
    MaxLet proc
        push EBP
        mov EBP, ESP
        sub ESP, 28
        push ECX
        push ESI
        push EBX
        
        mov ECX, 0
@L1:    mov byte ptr [EBP-28+ECX], 0
        inc ECX
        cmp ECX, 26
        jb @L1
        
        mov ESI, [EBP+8]
        mov EAX, [EBP+12] 
        
        mov ECX, 0
        mov EBX, 0
@L2:    mov BL, [ESI+ECX]
        cmp BL, 'a'
        jb @F
        cmp BL, 'z'
        ja @F
        sub EBX, 'a'
        inc byte ptr [EBP-28+EBX]
@@:     inc ECX
        cmp ECX, EAX
        jb @L2
        
        mov CL, 0
        mov EBX, 0
@L3:    cmp byte ptr [EBP-28+EBX], CL
        jbe @F
        mov CL, byte ptr [EBP-28+EBX]
        mov EAX, EBX
@@:     inc EBX
        cmp EBX, 26
        jb @L3
        
        add EAX, 'a'

        pop EBX
        pop ESI
        pop ECX
        mov ESP, EBP
        pop EBP
        ret 4*2
    MaxLet endp
    
    Start:
        ConsoleTitle offset T
        push offset S
        call ReadText
        push EAX
        push offset S
        call MaxLet
        outstr 'Чаще других малых лат. букв встречается - '
        outcharln AL
        pause
        exit
    end Start
