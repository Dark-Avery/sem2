include console.inc

.data
T   db " �������� ����� (������ 110)     "
    db " ������_0 (����_0) '��������' ",0

.code
    Start:

        ConsoleTitle offset T

        
        pause
        exit
    end Start
