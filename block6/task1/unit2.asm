include console.inc

public Print
extern X: dword

.code
Print:  outwordln X
        
        pause 'Нажмите любую клавишу...'
        exit
    end
