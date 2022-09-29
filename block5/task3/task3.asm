include console.inc
COMMENT ~
провер€ем симметричность, если симметрично, то пр€мо занул€ем 2 центральных
бита, если нет, то крайние биты сохран€ем в регистры (BH BL), при этом обнул€€
крайние биты регистра EAX, потом логическим сложением ставим их на новые места
выводим ответ ((не)симметрично) и выводим все 32 бита числа
~
.data
T   db " «€нчурин »горь (группа 110)     "
    db " «адача_3 (блок_5) 'јнализ и преобразование двоичного числа' ",0
ans db 'Ќ≈—»ћћ≈“–»„Ќќ',0
.code
    Start:
        ConsoleTitle offset T
        xor EAX, EAX
        xor ECX, ECX
input:  inchar BL
        cmp BL, ' '
        je input
        sub BL, '0'
        shl EAX, 1
        or AL, BL
        inc ECX
        cmp ECX, 32
        jne input
        
        lea ESI, ans
        
        mov EDX, EAX
@@:     shl EDX, 1
        rcr EBX, 1
        loop @B
        
        cmp EAX, EBX
        jne tru
        lea ESI, ans+2
        ;and EAX, 0FFFE7FFFh
        xor EDX, EDX
        xor EBX, EBX
        
        mov EDX, EAX
        and EDX, 0FFFF0000h
        shr EDX, 16
        mov ECX, 16
L1:     test DX, 1b
        jz @F
        and DL, 0FEh
        jmp next1
@@:     ror DX, 1
        loop L1
        
next1:  jECXZ @F
L2:     ror DX, 1
        loop L2
        
@@:     mov EBX, EAX
        and EBX, 0FFFFh
        
        mov ECX, 16
L3:     test BX, 8000h
        jz @F
        and BX, 7FFFh
        jmp next2
@@:     rol BX, 1
        loop L3
        
next2:  jECXZ @F
L4:     rol BX, 1
        loop L4
        
@@:     shl EDX, 16
        or EDX, EBX
        mov EAX, EDX
        jmp fin
        
tru:    xor BX, BX
        shl EAX, 1
        adc BH, 0
        shr EAX, 2
        adc BL, 0
        shl EAX, 1
        rol EAX, 1
        or AL, BL
@@:     ror EAX, 1
        or AL, BH
        
        
fin:    mov ECX, 8
        outstrln ESI
        
output: rol EAX, 1
        mov DL, 0
        adc DL, 0
        outword DL
        rol EAX, 1
        mov DL, 0
        adc DL, 0
        outword DL
        rol EAX, 1
        mov DL, 0
        adc DL, 0
        outword DL
        rol EAX, 1
        mov DL, 0
        adc DL, 0
        outword DL
        outchar ' '
        dec ECX
        jnz output
        newline
        
        pause
        exit
    end Start
