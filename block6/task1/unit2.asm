include console.inc

public Print
extern X: dword

.code
Print:  outwordln X
        
        pause '������� ����� �������...'
        exit
    end
