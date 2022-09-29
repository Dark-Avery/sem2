comment *
-------------------------------------------------------------------
�����-5 (������_2, ��������������� ������) 
-------------------------------------------------------------------
*

include console.inc

public In_text, Out_text, Find_min_word 

.code
;-----------------------------------------------------------------------
; procedure In_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ��������: ���� ����� �� � ����, �������������� ��� � �������� ��������
; � ���������� ����� ����� �� ������, ��������� ���������� Elem_of_Array.
; ����� ���������� ������ ��������� In_word  "������" ����� ����� 
; (������������� flush) �� ����������� ��������, �������� � ����� � 
; ���������� ������� ������� ENTER (������� ��� �����������, ����� ���������� 
; ���� ����� �������������� ����������� !!!). 
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
; ��������: ����� ����� �� � ����, ����� ������ ����� ����� 
; ���������� Elem_of_Arr. 
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
; ��������: ���� ������������������ �� N ���� (�� � ���� � ������ �����), 
; �������������� ���� � �����.�������� � ���������� �� � ������� Arr_of_words.
; � �������� ������ ��������� In_text ���������� � ��������������� ���������
; In_word ��� ����� ���������� ����� � ���������� ��� � ��������� �������� 
; ������� Arr_of_words
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
; ��������: ����� N ���� (�� � ���� � ������ �����), ������ ����� � � ����� 
; ������ ������. ����� ������ ������� �� ���� ������� ���������� Arr_of_words.
; � �������� ������ ��������� Out_text ���������� � ��������������� ���������
; Out_word ��� ������ ���������� �����
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
; ��������: ����� ����� (� ������� Arr_of_words), ������� ����������������� 
; ������������ ���� ��������� ������ � ����� ���������� ����� �� �����.
; ����� ������ ������� �� N ���� (������ ����� ������ � ����) ������� 
; ���������� Arr_of_words.
; � �������� ����� ������ ��������� Find_min_word ���������� � ���������������
; ��������� Out_word ��� ������ ���������� �����.
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