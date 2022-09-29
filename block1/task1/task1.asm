include console.inc

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_1 (блок_1) 'Степень тройки' ",0
    

.code
    Start:
        ConsoleTitle offset T 
        
        inint EAX, 'Введите число: '
        mov EDX, 0
        mov CL, 0
        mov EBX, 3
        
L:      cmp EAX, 1
        je fin
        div EBX
        cmp EDX, 0
        jne er
        inc CL
        jmp L
        
er:     mov CL, -1

fin:    outintln CL,,"Ответ "
        
        pause               
        exit                
    end Start
