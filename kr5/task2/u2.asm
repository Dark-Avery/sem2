comment *
-------------------------------------------------------------------
ВЫХОД-5 (Задача_2, вспомогательный модуль) 
-------------------------------------------------------------------
*

include console.inc

public In_text, Out_text, Find_min_word 

.code
;-----------------------------------------------------------------------
; procedure In_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; Действие: ввод слова из К букв, преобразование его к верхнему регистру
; и сохранение этого слова по адресу, заданному параметром Elem_of_Array.
; Перед окончанием работы процедура In_word  "чистит" буфер ввода 
; (макрокомандой flush) от управляющих символов, попавших в буфер в 
; результате нажатия клавиши ENTER (сделать это обязательно, иначе дальнейший 
; ввод будет осуществялться некорректно !!!). 
;-----------------------------------------------------------------------
In_word proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov ECX, [EBP+12]
    mov EBX, [EBP+8]
    
    xor EDX, EDX
    
@L: inchar AL
    and AL, 11011111b
    mov [EBX+EDX], AL
    inc EDX
    cmp EDX, ECX
    jne @L
    
    flush 
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
In_word endp

;-----------------------------------------------------------------------
; procedure Out_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; Действие: вывод слова из К букв, адрес начала слова задан 
; параметром Elem_of_Arr. 
;-----------------------------------------------------------------------
Out_word proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov ECX, [EBP+12]
    mov EBX, [EBP+8]
    
    xor EDX, EDX
    
@L: mov AL,[EBX+edx] 
    outchar AL
    inc EDX
    cmp EDX, ECX
    jne @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Out_word endp

;-----------------------------------------------------------------------
; procedure In_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; Действие: ввод последовательности из N слов (по К букв в каждом слове), 
; преобразование слов к верхн.регистру и сохранение их в массиве Arr_of_words.
; В процессе работы процедура In_text обращается к вспомогательной процедуре
; In_word для ввода очередного слова и сохранения его в очередном элементе 
; массива Arr_of_words
;-----------------------------------------------------------------------
In_text proc
    push EBP
    mov EBP,ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    
    mov EDX, [EBP+16]
    mov ECX, [EBP+12]
    mov EBX, [EBP+8]
    
    xor EAX, EAX
    
@L: push EDX
    mov EDI, EBX
    add EDI, EAX
    push EDI
    call In_word
    add EAX, EDX
    loop @L
    
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
In_text endp

;-----------------------------------------------------------------------
; procedure Out_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; Действие: вывод N слов (по К букв в каждом слове), каждое слово – с новой 
; строки экрана. Адрес начала массива из слов задаётся параметром Arr_of_words.
; В процессе работы процедура Out_text обращается к вспомогательной процедуре
; Out_word для вывода очередного слова
;-----------------------------------------------------------------------
Out_text proc
    push EBP
    mov EBP,ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    
    mov EDX, [EBP+16]
    mov ECX, [EBP+12]
    mov EBX, [EBP+8]
    
    xor EAX, EAX
    
@L: push EDX
    mov EDI, EBX
    add EDI, EAX
    push EDI
    call Out_word
    newline
    add EAX, EDX
    loop @L
    
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
Out_text endp	

;-----------------------------------------------------------------------		
; procedure Find_min_word(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; Действие: поиск слова (в массиве Arr_of_words), которое лексикографически 
; предшествует всем остальным словам и вывод найденного слова на экран.
; Адрес начала массива из N слов (каждое слово длиной К букв) задаётся 
; параметром Arr_of_words.
; В процессе своей работы процедура Find_min_word обращается к вспомогательной
; процедуре Out_word для вывода найденного слова.
;-----------------------------------------------------------------------  
Find_min_word proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, [EBP+8]
    mov EDX, [EBP+12]
    dec EDX
    mov ECX, [EBP+16]
    
    mov EAX, ESI
    
@L: add ESI, ECX
    mov EDI, EAX
    push ESI
    push ECX
repE cmpsb
    pop ECX
    pop ESI
    jae @F
    mov EAX, ESI
@@: dec EDX
    jnz @L
    
    push ECX
    push EAX
    call Out_word
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
Find_min_word endp			
;-----------------------------------------------------------------------
	
end