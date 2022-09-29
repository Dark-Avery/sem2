; main-home-ex1.asm (головной модуль)
; «адача_1 (из д-з по ћќƒ”Ћяћ)
include console.inc

public X, Y, Return
extern  Input: near, MAX_MIN@0: near

.data
X    dd   ?          ; c/зн
Y    dd   ?          ; c/зн
MAX  dd   ?
MIN  dd   ?
 
.code

Start:
    jmp Input        ; передача управлени€ в 1-ый вспомогательный модуль (unit1)
	                 ; дл€ ввода значений переменных X и Y
Return:              ; вернулись в эту точку из unit1 (после ввода X и Y)
	;подготовка к вызову MAX_MIN(X, Y, MAX, MIN)
    ;укладываем параметры в стек (в обратном пор€дке)
    push offset MIN  ; адрес MIN -> в стек
    push offset MAX  ; адрес MAX -> в стек
    push Y           ; значение Y -> в стек
    push X           ; значение ’ -> в стек
    call MAX_MIN@0   ; передача управлени€ во 2-ой вспомогательный модуль (unit2)
    outint MAX,,"MAX = "
    outintln MIN,,"  MIN = "

    exit

end Start

comment ~

»Ќ—“–” ÷»я ѕќ –ј«–јЅќ“ ≈ Ё“ќ… “–®’ћќƒ”Ћ№Ќќ… ѕ–ќ√–јћћџ:

поместить пакетный файл prompt1.bat в тот каталог, где наход€тс€ исходные 
ассемблерные модули (main-home-ex1.asm, unit1-home-ex1.asm и unit2-home-ex1.asm)
и запустить его (откроетс€ окно командной строки)

дл€ трансл€ции этого модул€ (main-home-ex1.asm) выполнить из командной строки:
ml /c /coff /Fl main-home-ex1.asm

дл€ трансл€ции 1-го вспомогательного модул€ (unit1-home-ex1.asm) выполнить 
из командной строки:
ml /c /coff /Fl unit1-home-ex1.asm

дл€ трансл€ции 2-го вспомогательного модул€ (unit2-home-ex1.asm) выполнить 
из командной строки:
ml /c /coff /Fl unit2-home-ex1.asm

дл€ сборки (линковки) трЄх модулей выполнить из командной строки:
link /subsystem:console main-home-ex1.obj unit1-home-ex1.obj unit2-home-ex1.obj

дл€ запуска готовой программы на счЄт выполнить из командной строки:
main-home-ex1

~