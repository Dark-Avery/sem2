; вспомогательный модуль (unit-home-ex2.asm)
; Для снятия проблем с заданием путей к подключаемым библиотекам
; рассматривается случай вспомогательного модуля, который в процессе
; своей работы не использует макросов, объявленных в файле console.inc.
; Поэтому не используем в этом модуле директиву include console.inc.
; Ограничимся следующей парой минимально необходимых директив 
; (установливающих нужные режимы трансляции):
.686
.model flat, stdcall

public MAX_MIN          ; точка входа в модуль 

.code
; procedure MAX_MIN(X, Y: longint; var MAX, MIN: longint)
; Действие:
; MAX := максимум(X,Y)
; MIN := минимум(X,Y)
MAX_MIN proc
;ст.соглашения о связях stdcall
    push EBP
    mov EBP,ESP
    
    push EAX
    push EBX
    push ECX
    push EDX

    mov EAX,[EBP+8]      ; X c/зн
    mov EBX,[EBP+12]     ; Y c/зн
    
    mov ECX,[EBP+16]     ; offset MAX
    mov EDX,[EBP+20]     ; offset MIN
    
    cmp EAX,EBX
    jGE @F
    xchg EAX,EBX
@@: ;EAX = MAX, EBX = MIN
    mov [ECX],EAX       ; MAX
    mov [EDX],EBX       ; MIN
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    
    pop EBP
    ret 4*4
    
MAX_MIN endp    

end 

поместить пакетный файл prompt1.bat в тот каталог, где находится данный 
ассемблерный модуль unit-home-ex2.asm  и головной модуль (на Free Pascal) 
main-home-ex2.pas.  Запустить prompt1.bat, откроется окно командной строки.

для трансляции этого модуля (unit-home-ex2.asm) выполнить из командной строки:
ml /c /coff /Fl unit-home-ex2.asm