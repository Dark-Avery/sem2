include console.inc

COMMENT *

 ������� �������� �����     ������ 110

 ��������������� ������ 10 (12.04.2021)

 ������_2 (25 �����)
 
 ����� �� ����� Free Pascal ���� ��������� ��������:
 const N = 10;
 type vector = array [1..N] of longint;
 
 ������� ��������� Sum(X,N) �� ������������ ������������ � ������ stdcall
 ��� ��������� ��������:
 X - ������ ���� vector, N - ����������� ����� ������� 
 ��������� ����������� ������ � �� ���������� �������: 
 for i:= 1 to N-1 do X[i]:= X[i]+X[N];
 (����� �� ��������� longint �� ��������������)

 �������� ��������� � ���� ��������� ��� ������� Y, �������� ��������
 ���� � ������ ������ ���� ���������, � �����  ��������� � ���������
  - ������� ������ Y ����� ��������� (����� ����� ����������� ��������, 
  �� �������� ��� ����� ����������� ���������, �.�. ����� ����� �����
  ������ ��� �������� ������������ ������ ��������� Sum).

*
.data
T   db " �������______ ���______   ������_2 (�-� 10)",0		
N   = 10
Y   dd 1,-20,300,-4000,50000,-6000000,70000000,-800000000,2000000000,-1 ; �/��

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
    ;	����� ����������� ������� ���������
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
        
        pause						; ����� ��� ����� �� e-mail
        exit						
        end Start
