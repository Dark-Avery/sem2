include console.inc

COMMENT *

 СТУДЕНТ Зянчурин Игорь     группа 110

 САМОСТОЯТЕЛЬНАЯ РАБОТА 10 (12.04.2021)

 ЗАДАЧА_1 (25 очков)
 
 Описать процедуру Assign(A,B), реализующую следующее действие: 
 B := (A-13) mod B 
 Здесь A – слово с/зн, B – байт с/зн (отличен от нуля). 
 Параметр А передаётся по значению через регистр AX.  
 Параметр В передаётся по ссылке через регистр EBX. 
 Выписать обращение к этой процедуре для переменных A и B,
 описание которых приведено в секции данных (предварительно
 ввести значения этих переменных, а после  обращения к процедуре
 - вывести новое значение переменной В).
 Возможные тесты приведены в конце программы.

*
.data

T   db " Зянчурин Игорь   Задача_1 (с-р 10)",0		
A   dw ?  ; c/зн
B   db ?  ; с/зн

.code
    Assign proc
        push EAX
        push EDX
        push ECX
        
        movsx EAX, AX
        sub EAX, 13
        cdq
        mov CL, [EBX]
        movsx ECX, CL
        idiv ECX
        mov [EBX], DL
        
        pop ECX
        pop EDX
        pop EAX
        ret
    Assign endp
    
    Start:
    ;	здесь размещаются команды программы
        ConsoleTitle offset T	
        inint A,'A = '
        inint B,'B = '
        lea EBX, B
        mov AX, A
        call Assign
        outint B,,'(A-13) mod B = '
        pause						; нужно при сдаче по e-mail
        exit						
        end Start
    
Тесты:
A = -32768  B = -1    (A-13) mod B = 0   
A = -32768  B = 2     (A-13) mod B = -1   
A = -32768  B = -128  (A-13) mod B = -13
A =  32767  B = 127   (A-13) mod B = 115 
A = -32767  B = 127   (A-13) mod B = -14     