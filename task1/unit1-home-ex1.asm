; 1-ый вспомогательный модуль (unit1-home-ex1.asm)
include console.inc

public Input  ; точка входа в модуль 
extern X: dword, Y: dword, Return: near 
; X, Y, RETURN - описаны в головном модуле

.code
Input:
    inint X,"X = "
    inint Y,"Y = "
    jmp Return 
end 