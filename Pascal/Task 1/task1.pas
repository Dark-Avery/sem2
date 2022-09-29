{$mode TP}
{$R+,B+,X-}
{$codepage UTF-8}
program task_01(input, output);
const 
    eps = 0.001;
type
    TF = function(x: real): real;
var
    x12, x13, x23, S, eps1, eps2: real;

function f1(x: real): real;
begin
    f1 := exp(-x) + 3;
end;

function f1d(x: real): real;
begin
    f1d := -exp(-x);
end;

function f2(x: real): real;
begin
    f2 := 2 * x - 2;
end;

function f2d(x: real): real;
begin
    f2d := 2;
end;

function f3(x: real): real;
begin
    f3 := 1 / x;
end;

function f3d(x: real): real;
begin
    f3d := -1 / (x * x);
end;

procedure root(f, g, f1, g1: TF; a, b, eps1: real; var x: real);
var 
    c1, c2: real;
    cond1, cond2: boolean;

function fg(x: real): real;
begin
    fg := f(x) - g(x);
end;

function fg1(x: real): real;
begin
    fg1 := f1(x) - g1(x);
end;

begin
    cond1 := fg(a) < 0;
    cond2 := fg((a + b) / 2) < (fg(a) + fg(b)) / 2;
    if cond1 = cond2 then
        repeat
            c1 := (a * fg(b) - b * fg(a)) / (fg(b) - fg(a));
            c2 := b - fg(b) / fg1(b);
            a := c1;
            b := c2;
        until abs(c1 - c2) < eps1
    else
        repeat
            c1 := (a * fg(b) - b * fg(a)) / (fg(b) - fg(a));
            c2 := a - fg(a) / fg1(a);
            a := c2;
            b := c1
        until abs(c1 - c2) < eps1;
    x := (c1 + c2) / 2
end;

function integral(f: TF; a, b, eps2: real): real;
var
    n, i: integer;
    h, sum, sum4, I2, I1, d, x, p: real;
begin
    p := 1 / 15;
    n := 2;
    h := (b - a) / n;
    sum := f(a) + f(b);
    sum4 := f(a + h);
    I2 := (h / 3) * (sum + 4 * sum4);
    repeat
        I1 := I2;
        n := n * 2;
        h := h / 2;
        sum := sum + sum4 * 2;
        sum4 := 0;
        x := a + h;
        d := 2 * h;
        for i := 1 to n div 2 do begin
            sum4 := sum4 + f(x);
            x := x + d
        end;
        I2 := (h / 3) * (sum + 4 * sum4)
    until abs(I2 - I1) * p < eps2;
    integral := I2
end;

begin
    writeln('Zyanchurin Igor            110');
    writeln('Task 1. Calculation of the roots of equations and definite integrals.');
    writeln('Number of three functions - 3');
    writeln('Root search method name - combined');
    writeln('Calculating a definite integral method name - parabola');
    eps1 := eps / 10;
    eps2 := eps1;
    root(f1, f2, f1d, f2d, 2, 3, eps1, x12);
    root(f2, f3, f2d, f3d, 1, 2, eps1, x23);
    root(f1, f3, f1d, f3d, 0.1, 1, eps1, x13);
    S := integral(f1, x13, x12, eps2) - integral(f3, x13, x23, eps2) - integral(f2, x23, x12, eps2);
    writeln(x13:3:4, ' ', x23:3:4, ' ', x12:3:4, ' ', 'S = ', S:3:3)
end.