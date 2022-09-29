include console.inc

COMMENT *

 ������� �������� �����     ������ 110

 ��������������� ������ 10 (12.04.2021)

 ������_1 (25 �����)
 
 ������� ��������� Assign(A,B), ����������� ��������� ��������: 
 B := (A-13) mod B 
 ����� A � ����� �/��, B � ���� �/�� (������� �� ����). 
 �������� � ��������� �� �������� ����� ������� AX.  
 �������� � ��������� �� ������ ����� ������� EBX. 
 �������� ��������� � ���� ��������� ��� ���������� A � B,
 �������� ������� ��������� � ������ ������ (��������������
 ������ �������� ���� ����������, � �����  ��������� � ���������
 - ������� ����� �������� ���������� �).
 ��������� ����� ��������� � ����� ���������.

*
.data

T   db " �������� �����   ������_1 (�-� 10)",0		
A   dw ?  ; c/��
B   db ?  ; �/��

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
    ;	����� ����������� ������� ���������
        ConsoleTitle offset T	
        inint A,'A = '
        inint B,'B = '
        lea EBX, B
        mov AX, A
        call Assign
        outint B,,'(A-13) mod B = '
        pause						; ����� ��� ����� �� e-mail
        exit						
        end Start
    
�����:
A = -32768  B = -1    (A-13) mod B = 0   
A = -32768  B = 2     (A-13) mod B = -1   
A = -32768  B = -128  (A-13) mod B = -13
A =  32767  B = 127   (A-13) mod B = 115 
A = -32767  B = 127   (A-13) mod B = -14     