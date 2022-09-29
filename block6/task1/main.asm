include console.inc

In4 proto
Out4 proto
public X
extern Print: near

.data
T   db " Зянчурин Игорь (группа 110)     "
    db " Задача_1 (блок_6) 'Ввод-вывод четверичного числа' ",0
X   dd ?
.code
    Start:
        ConsoleTitle offset T
        outstrln 'Введите 4-чное число: '
        push offset X
        call In4
        outstrln 'Ваше число: '
        push X
        call Out4
        outstrln 'Ваше число на регистре выглядит так: '
        jmp Print        
    end Start
