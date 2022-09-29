include console.inc

Mult proto
public A, B, Z
extern comul: near

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_2 (блок_6) 'Сверхдлинное умножение' ",0
A   dd ?
B   dd ?
Z   dq ?
.code
    Start:
        ConsoleTitle offset T
        inint A,'Введите A и B: '
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
