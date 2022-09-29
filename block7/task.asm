include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_1 (блок_7) 'МАКРОСРЕДСТВА' ",0
K1 equ 1
K2 equ 2
K3 equ 3
B1 db 10
B2 db 20
B3 db 30
W1 dw 4000
W2 dw 5000
W3 dw 6000
D1 dd 700000
D2 dd 800000
D3 dd 900000
.code
    Sum macro Res:=<EAX>, Terms:vararg
    local K, co, p, i, byl, byh, w, sc
        K = 0
        for reg, <EAX, EBX, ECX, EDX, EDI, ESI, EBP>
            ifdifi <Res>, <reg>
                K = K + 1
            else
                exitm
            endif
        endm
        if K EQ 7
            echo Wrong argument (Res) in macro Sum
            .err <Wrong argument (Res) in macro Sum>
            exitm
        endif
        ifnb <Terms>
            co = 0
            p = 0
            i = 0
            byl = 0
            byh = 0
            w = 0
            sc = 0
            for T, <Terms>
                ifidni <Res>, <T>
                    push Res
                    exitm
                endif
            endm
            for T, <Terms>
                ifidni <Res>, <T>
                    p = p + 1
                endif
            endm
            for reg, <<AX,AH,AL>,<BX,BH,BL>,<CX,CH,CL>,<DX,DH,DL>,<DI>,<SI>,<BP>>
                if K EQ i
                    for R, <reg>
                        if sc EQ 0
                            for T, <Terms>
                                ifidni <R>, <T>
                                    sub ESP, 4
                                    push EBX
                                    movzx EBX, R
                                    mov [ESP+4], EBX
                                    pop EBX
                                    exitm
                                endif
                            endm
                            for T, <Terms>
                                ifidni <R>, <T>
                                    w = w + 1
                                endif
                            endm
                        elseif sc EQ 1
                            for T, <Terms>
                                ifidni <R>, <T>
                                    sub ESP, 4
                                    push EBX
                                    movzx EBX, R
                                    mov [ESP+4], EBX
                                    pop EBX
                                    exitm
                                endif
                            endm
                            for T, <Terms>
                                ifidni <R>, <T>
                                    byh = byh + 1
                                endif
                            endm
                        elseif sc EQ 2
                            for T, <Terms>
                                ifidni <R>, <T>
                                    sub ESP, 4
                                    push EBX
                                    movzx EBX, R
                                    mov [ESP+4], EBX
                                    pop EBX
                                    exitm
                                endif
                            endm
                            for T, <Terms>
                                ifidni <R>, <T>
                                    byl = byl + 1
                                endif
                            endm
                        endif
                        sc = sc + 1
                    endm       
                endif
                i = i + 1 
            endm
            xor Res, Res
            for ter, <Terms>
                ifnb <ter>
                    if type ter EQ 0
                        co = co + ter 
                    elseif type ter EQ 1 or type ter EQ 2
                        ifidni <Res>, <EAX>
                            ifdifi <ter>, <AL>
                                ifdifi <ter>, <AH>
                                    ifdifi <ter>, <AX>
                                        push EBX
                                        movzx EBX, ter
                                        add Res, EBX
                                        pop EBX
                                    endif
                                endif
                            endif
                        elseifidni <Res>, <EBX>
                            ifdifi <ter>, <BL>
                                ifdifi <ter>, <BH>
                                    ifdifi <ter>, <BX>
                                        push EAX
                                        movzx EAX, ter
                                        add Res, EAX
                                        pop EAX
                                    endif
                                endif
                            endif
                        elseifidni <Res>, <ECX>
                            ifdifi <ter>, <CL>
                                ifdifi <ter>, <CH>
                                    ifdifi <ter>, <CX>
                                        push EAX
                                        movzx EAX, ter
                                        add Res, EAX
                                        pop EAX
                                    endif
                                endif
                            endif
                        elseifidni <Res>, <EDX>
                            ifdifi <ter>, <DL>
                                ifdifi <ter>, <DH>
                                    ifdifi <ter>, <DX>
                                        push EAX
                                        movzx EAX, ter
                                        add Res, EAX
                                        pop EAX
                                    endif
                                endif
                            endif
                        elseifidni <Res>, <EDI>
                            ifdifi <ter>, <DI>
                                push EAX
                                movzx EAX, ter
                                add Res, EAX
                                pop EAX
                            endif
                        elseifidni <Res>, <ESI>
                            ifdifi <ter>, <SI>
                                push EAX
                                movzx EAX, ter
                                add Res, EAX
                                pop EAX
                            endif
                        elseifidni <Res>, <EBP>
                            ifdifi <ter>, <BP>
                                push EAX
                                movzx EAX, ter
                                add Res, EAX
                                pop EAX
                            endif
                        else
                            push EAX
                            movzx EAX, ter
                            add Res, EAX
                            pop EAX
                        endif
                    elseif type ter EQ 4
                        ifdifi <Res>, <ter>
                            add Res, ter
                        endif
                    endif
                endif
            endm
            if co NE 0
                add Res, co
            endif
            for deep, <byl, byh, w, p>
                repeat deep
                    add Res, [ESP]
                endm
                if deep NE 0
                    add ESP, 4
                endif
            endm 
        endif
    endm
    
    Start:
        ConsoleTitle offset T
.LISTMACRO
        ;mov EBX, 1
        ;outwordln EBX,,'EBX = '
        Sum EAX,<123456,K1,EBX,D1>
        ;outwordln EAX,,'EAX = 123456 + K1(1) + EBX + D1(700000) = '
        Sum EAX,123456,K1,EBX,D1
        ;outwordln EAX,,'EAX = 123456 + K1(1) + EBX + D1(700000) = '
        Sum ,123456,K1,EBX,D1
        ;outwordln EAX,,'EAX = 123456 + K1(1) + EBX + D1(700000) = '
        Sum EAX,123456, ,K1,EBX,D1
        ;outwordln EAX,,'EAX = 123456 + K1(1) + EBX + D1(700000) = '
        Sum EAX
        ;outwordln EAX,,'EAX = '
        Sum
        ;outwordln EAX,,'EAX = '
        Sum EAX,2,K2,B2,W2,D2
        ;outwordln EAX,,'EAX = 2 + K2(2) + B2(20) + W2(5000) + D2(800000) = '
        Sum AL,1,2,3
        Sum CX,1,K2
        Sum K3,1,2,3
        Sum AL,1,2,3
        Sum B3,1,2,3
        Sum W3,1,2,3
        Sum ESP,1,2,3
        Sum EDX,1,B2,W2, ,K2,D3,123
        ;outwordln EDX,,'EDX = 1 + B2(20) + W2(5000) + K2(2) + D3(900000) + 123 = '
        
        ;for reg, <AL, AH, BL, BH, DL, DH>
        ;    mov reg, 1
        ;endm
        ;outstrln '8-битные регистры равны 1'
        Sum ESI,AL,2,3,AH,K1,K2,BL,BH,DL,DH
        ;outwordln ESI,,'ESI = AL + 2 + 3 + AH + K1(1) + K2(2) + BL + BH + DL + DH = '
        
        ;for reg, <AX, BX, CX, DX>
        ;    mov reg, 2
        ;endm
        ;outstrln '16-битные регистры равны 2'
        Sum EDI,AX,BX,CX,DX,W1,W2,123
        ;outwordln EDI,,'EDI = AX + BX + CX + DX + W1(4000) + W2(5000) + 123 = '
        Sum 0,1,2,3
        
        ;newline
        ;outstrln '************************'
        ;newline
        
        ;mov EDX, 10
        ;outwordln EDX,,'EDX = '
        Sum EDX,EDX ,B2,EDX, ,K2,D3,EDX
        ;outwordln EDX,,'EDX = EDX + B2(20) + EDX + K2(2) + D3(900000) + EDX = '
        
        ;mov EAX, 10
        ;outwordln EAX,,'EAX = '
        Sum ,1,EAX,EAX, ,K2,EAX,123
        ;outwordln EAX,,'EAX = 1 + EAX + EAX + K2(2) + EAX + 123 = '
        
        ;newline
        ;outstrln '************************'
        ;newline
        
        ;mov CX, 300
        ;outwordln CX,,'CX = '
        ;outwordln CH,,'CH = '
        ;outwordln CL,,'CL = '
        Sum ECX,CL,CH, ,CX,CL,CH,CX
        ;outwordln ECX,,'ECX = CL + CH + CX + CL + CH + CX = '
        
        ;mov EAX, 300
        ;outwordln EAX,,'EAX = '
        ;outwordln AX,,'AX = '
        ;outwordln AH,,'AH = '
        ;outwordln AL,,'AL = '
        Sum ,AL,AL,AH, ,AH,AX,AX,EAX,EAX
        ;outwordln EAX,,'EAX = AL + AL + AH + AH + AX + AX + EAX + EAX = '
        
        
.NOLISTMACRO
        newline
        pause 'Нажмите любую клавишу...'
        exit
    end Start
