; 
; �������� ����� 110

comment ~

c-p 13    (max = 60 �����)
�������� ���������, ��������� �� ���� �������.

� �������� ������ ������ ���� �������: 
1) �������� ��������� � ������ K � ��������� �� ��������� [0..31]
  (������������ � ��������� ��� ������������� �������� 29); 
2) ������ S ��� ������ ��������� �Overflow�; 
3) ������� ����� � ������ D; 
4) ���� � ������ B. 

�������� ������  ������  ��������  �������� �� ���� �����������  
���������� B (�� ������������ inint), � ����� ������� ���������� 
�� ��������������� ������. 

�� ��������������� ������ ����������� ��������: 
������������ �� �������� B*(2^K) � ������ �������� �����?

���� ������������, �� ��������� ��������� �������� (���� �� ������):
1) ��������� (�� ��������������� ������) ���������� D �������� B*(2^K); 
2) ���������� ���������� � �������� ������;
3) �������� �� ��������� ������ ���������� �������� ���������� D;
4) ��������� ������ ��������� (� �������� ������).

���� �� ������������, �� ��������� ��������� �������� (���� �� ������):
1) ���������� (������������� outstr �� ���������������� ������) �����, 
�������� � ������ S; 
2) ��������� ������ ��������� (�� ��������������� ������).

�����������: ������ "B*(2^K)" ���������� ��������� �������� ��������
���������� � �� ��� � ������� �

���������� � ����������: �� ������������ �������������� ������. 
����������� "�������" ��������.

~

; (main_sername.asm) �������� ������
include console.inc
; ----------------  ����� ���� ������� -------------------------

public K, S, D, B, back
extrn P: near

.data
K equ 29
S db 'Overflow',0
D dd ?
B db ?
T db '�������� ����� 110 �-� 13',0
.code
    Start:
        ConsoleTitle offset T
        inint B,'B = '
        jmp P
back:   outwordln D,,'D = '
        pause
        exit
    end Start
; ---------------- ����� ������ ������� ------------------------

******************************************************

������ ��� ������������ 
(���� ����� ������ �������� � � ������ ��������� ������,  
 ������ ������������� ���� ������ � ������ ����������� ��� ������):

K=31, B=1              => D=2147483648, �.�. 1*(2^31)
K=31, B=2=10b          => Overflow
K=0,  B=255=11111111b  => D=255, �.�. 255*(2^0)
K=1,  B=255=11111111b  => D=510, �.�. 255*(2^1)
K=2,  B=255=11111111b  => D=1020, �.�. 255*(2^2)
K=23, B=255=11111111b  => D=2139095040, �.�. 255*(2^23)
K=24, B=255=11111111b  => D=4278190080, �.�. 255*(2^24)
K=25, B=255=11111111b  => Overflow
K=29, B=4=100b         => D=2147483648, �.�. 4*(2^29)
K=29, B=7=111b         => D=3758096384, �.�. 7*(2^29)
K=29, B=8=1000b        => Overflow

*******************************************************
���������� �� ���������� ���� ������������� ���������:

��������� �������� ���� prompt1.bat � ��� �������, ��� ��������� �������� 
������������ ������ (main_sername.asm � unit_sername.asm)

��� ���������� ����� ������ (main_sername.asm) ��������� 
�� ��������� ������:
ml /c /coff /Fl main_sername.asm

��� ���������� ���������������� ������ (unit_sername.asm) ��������� 
�� ��������� ������:
ml /c /coff /Fl unit_sername.asm

��� ������ (��������) ���� ���� ������� ��������� �� ��������� ������:
link /subsystem:console main_sername.obj unit_sername.obj /out:sername.exe

��� ������� ������� ��������� sername.exe �� ���� ��������� �� ��������� ������:
sername

