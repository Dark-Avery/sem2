include console.inc

.data
T   db " «€нчурин »горь (группа 110)     "   ; информаци€ об авторе программы
    db " «адача_4 (блок_3) '–ассвет' ",0       ; информаци€ о решаемой задаче

.code
    Start:
        outintln ESP,,'ESP = '
        newline
        mov EDI, ESP
        ConsoleTitle offset T
        inint EAX, '¬ведите высоты домов (в конце 0): '
        mov EBX, 1
        push EBX        ;номер дома
        push EAX        ;высота дома
            
L:      inint EAX
        cmp EAX, 0      ;конец ввода
        je choice
        inc EBX
        push EBX        ;суем номер дома
        push EAX        ;суем высоту дома
        jmp L
        
choice: flush           ;очистка буфера
        newline
        outstrln 'a - справа налево, b - слева направо (латинские)'
Lc:     outstr ' акой вариант хотите увидеть? a/b: '
        inchar AL
        cmp AL,'a'
        je gotoa
        cmp AL,'b'
        je gotob
        jmp Lc
        
gotoa:  mov ECX, 0      ;начальный максимум высоты дома
La:     pop EAX         ;вытаскиваем дома из стека (справа налево)
        pop EBX
        cmp EAX, ECX
        jLe nexta       ;если дом строго выше, то выводим его и мен€ем макс
        outint EAX
        outintln EBX,,':'
        mov ECX, EAX
nexta:  cmp EDI, ESP    ;остановка когда стек пуст
        jne La
        jmp fin
      
;gotob:  mov ECX, 0      ;делаем то же самое, что и в пункте а
;                        ;но вместо вывода загон€ем в свой "стек"
;        mov ESI, ESP    
;        sub ESI, 1000   ;отступаем вверх от ESP столько, чтобы
;        mov EDX, ESI    ;макрокоманды вывода не мен€ли наши значени€
;Lb1:    pop EAX
;        pop EBX
;        cmp EAX, ECX
;        jLe nextb
;        sub ESI, 4
;        mov [ESI], EBX
;        sub ESI, 4
;        mov [ESI], EAX
;        mov ECX, EAX
;nextb:  cmp EDI, ESP
;        jne Lb1

gotob:  mov ECX, 0       
        mov ESI, ESP    
        mov EDX, ESP
Lb1:    mov EAX, [ESI]
        add ESI, 4
        mov EBX, [ESI]
        add ESI, 4
        cmp EAX, ECX
        jLe nextb
        push EBX
        push EAX
        mov ECX, EAX
nextb:  cmp EDI, ESI
        jne Lb1
        
Lb2:    pop EAX
        pop EBX
        outint EAX
        outintln EBX,,':'
        cmp ESP, EDX
        jne Lb2
        
;Lb2:    mov EAX, [ESI]  ;в конце просто достаем из "стека" перевернутый ответ
;        add ESI, 4
;        mov EBX, [ESI]
;        add ESI, 4
;        outint EAX
;        outintln EBX,,':'
;        cmp ESI, EDX    ;остановка когда "стек" пуст
;        jne Lb2
        
fin:    newline
        mov ESP, EDI
        outintln ESP,,'ESP = '
        pause
        exit
    end Start
