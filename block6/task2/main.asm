include console.inc

Mult proto
public A, B, Z
extern comul: near

.data
T   db " �������� ����� (������ 110)     "
    db " ������_2 (����_6) '������������ ���������' ",0
A   dd ?
B   dd ?
Z   dq ?
.code
    Start:
        ConsoleTitle offset T
        inint A,'������� A � B: '
        inint B
        push offset Z
        push B
        push A
        call Mult
        outword A
        outchar '*'
        outword B
        outchar '='
        outwordln Z
        jmp comul
    end Start
