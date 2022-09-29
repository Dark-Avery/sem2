program m1;
var 
    X: longword;
    Res: shortint;
procedure Power2(X: longword; var Res: shortint);
stdcall;
external name '_Power2@0';  
{$L u1.obj}      

begin
    write('X = ');
    read(X);
    
    Power2(X, Res);
    
    writeln('Res = ', Res);
    readln;
    readln
end.
