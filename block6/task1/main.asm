include console.inc

In4 proto
Out4 proto
public X
extern Print: near

.data
T   db " �������� ����� (������ 110)     "
    db " ������_1 (����_6) '����-����� ������������ �����' ",0
X   dd ?
.code
    Start:
        ConsoleTitle offset T
        outstrln '������� 4-���� �����: '
        push offset X
        call In4
        outstrln '���� �����: '
        push X
        call Out4
        outstrln '���� ����� �� �������� �������� ���: '
        jmp Print        
    end Start
