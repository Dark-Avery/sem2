include console.inc

COMMENT *

 СТУДЕНТ Зянчурин Игорь     группа 110

 САМОСТОЯТЕЛЬНАЯ РАБОТА 10 (12.04.2021)

 ЗАДАЧА_2 (25 очков)
 
 Пусть на языке Free Pascal даны следующие описания:
 const N = 10;
 type vector = array [1..N] of longint;
 
 Описать процедуру Sum(X,N) со стандартными соглашениями о связях stdcall
 при следующих условиях:
 X - массив типа vector, N - размерность этого массива 
 Процедура преобразует массив Х по следующему правилу: 
 for i:= 1 to N-1 do X[i]:= X[i]+X[N];
 (выход из диапазона longint не контролировать)

 Выписать обращение к этой процедуре для массива Y, описание которого
 дано в секции данных этой программы, а после  обращения к процедуре
  - вывести массив Y после изменений (вывод можно осуществить напрямую, 
  не описывая для этого специальной процедуры, т.к. вывод здесь нужен
  только для контроля правильности работы процедуры Sum).

*
.data
T   db " ФАМИЛИЯ______ ИМЯ______   Задача_2 (с-р 10)",0		
N   = 10
Y   dd 1,-20,300,-4000,50000,-6000000,70000000,-800000000,2000000000,-1 ; с/зн

.code
    Sum proc
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        
        mov EAX, [EBP+8]
        mov ECX, [EBP+12]
        
        mov EBX, [EAX][4*ECX-4]
        dec ECX
@L:     add [EAX][4*ECX-4], EBX
        loop @L
        
        pop ECX
        pop EBX
        pop EAX
        pop EBP
        ret 4*2
    Sum endp
        
        
    Start:
    ;	здесь размещаются команды программы
        ConsoleTitle offset T	
        push N
        lea EAX, Y
        push EAX
        call Sum
        mov ECX, 0
output: outint Y[4*ECX],, ' '
        inc ECX
        cmp ECX, 10
        jb output
        newline
        
        pause						; нужно при сдаче по e-mail
        exit						
        end Start
