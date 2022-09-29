{$mode TP}
{$R+,B+,X-}
{$codepage UTF-8}
program task_02(input, output);
uses crt;
var
    n: shortint;
    p: char;
    again: boolean; 
    score, maxscore: longint; 

function lower(k: integer): longint;
var
    i: integer;
    ans: longint;
begin
    ans := -1;
    for i := 1 to k - 1 do
        ans := ans * 2;
    lower := ans
end;

function upper(k: integer): longint;
var
    i: integer;
    ans: longint;
begin
    ans := 1;
    for i := 1 to k do
        ans := ans * 2;
    upper := ans - 1
end;

procedure summ(x, y, max, min: longint; var sign, nsign: longint; var CF, OVF, SF, ZF: boolean);
var
    xs, ys, xns, yns, summns, summs: longint;
begin
    xs := x;
    ys := y;
    if x < 0 then
        xns := x + max + 1
    else
        xns := x;
    if y < 0 then
        yns := y + max + 1
    else
        yns := y;
    summns := xns + yns;
    if summns > max then begin
        CF := true;
        nsign := summns - (max + 1);
    end else begin
        CF := false;
        nsign := summns
    end;
    if xs > (max div 2) then
        xs := xs - (max + 1);
    if ys > (max div 2) then
        ys := ys - (max + 1);
    summs := xs + ys;
    if summs < min then begin
        OVF := true;
        summs := summs + max + 1
    end else if summs > (max div 2) then begin
        OVF := true;
        summs := summs - (max + 1)
    end else
        OVF := false;
    ZF := false;
    SF := false;
    if summs < 0 then
        SF := true
    else if summs = 0 then
        ZF := true;
    sign := summs
end;

procedure diff(x, y, max, min: longint; var sign, nsign: longint; var CF, OVF, SF, ZF: boolean);
var
    xs, ys, xns, yns, diffns, diffs: longint;
begin
    xs := x;
    ys := y;
    if x < 0 then
        xns := x + max + 1
    else
        xns := x;
    if y < 0 then
        yns := y + max + 1
    else
        yns := y;
    diffns := xns - yns;
    if diffns < 0 then begin
        CF := true;
        nsign := diffns + (max + 1);
    end else begin
        CF := false;
        nsign := diffns
    end;
    if xs > (max div 2) then
        xs := xs - (max + 1);
    if ys > (max div 2) then
        ys := ys - (max + 1);
    diffs := xs - ys;
    if diffs < min then begin
        OVF := true;
        diffs := diffs + max + 1
    end else if diffs > (max div 2) then begin
        OVF := true;
        diffs := diffs - (max + 1)
    end else
        OVF := false;
    ZF := false;
    SF := false;
    if diffs < 0 then
        SF := true
    else if diffs = 0 then
        ZF := true;
    sign := diffs
end;
    
procedure calculator;
var
    k: integer;
    x1, x2, sds, sdns, low, up: longint;
    n: shortint;
    CF, OVF, SF, ZF, OK: boolean;
    
procedure binary(x, max: longint);
begin
    if x < 0 then
        x := x + up + 1;
    while (x > 0) or (max > 0) do begin
        if x < max then
            write(0)
        else begin
            write(1);
            x := x - max;
        end;
        max := max div 2;
    end;
end;

procedure nosign(x: longint);
begin
    if x >= 0 then
        write(x)
    else
        write(x + up + 1)
end;

procedure sign(x: longint);
begin
    if x <= 0 then
        write(x)
    else if x < (up div 2 + 1) then
        write('+', x)
    else
        write(x - (up + 1))
end;

begin
    k := 2;
    Window(1,1,80,25);
    textbackground(0);
    clrscr;
    Window(19,4,62,16);
    textbackground(7);
    clrscr;
    Window(18,21,63,25);
    clrscr;
    gotoxy(3,2);
    textcolor(0);
    write('Управление производится при помощи стрелок');
    gotoxy(3,4);
    write('Если передумали, нажмите ESC');
    textbackground(0);
    Window(21,5,60,15);
    clrscr;
    textcolor(15);
    gotoxy(4,9);
    write('Для подтверждения нажмите Enter');
    gotoxy(4,6);
    write('Диапазон чисел: [', lower(k), ';', upper(k), ']');
    gotoxy(4,3);
    write('Выберите количество бит: <  >');
    gotoxy(30,3);
    textbackground(7);
    textcolor(0);
    write(k, ' ');
    gotoxy(30,3);
    p := readkey;
    while (ord(p) <> 27) and (ord(p) <> 13) do begin
        if ord(p) = 0 then begin
            p := readkey;
            if ((ord(p) = 77) or (ord(p) = 72)) and (k < 16) then begin
                k := k + 1;
                textbackground(7);
                textcolor(0);
                if k >= 10 then
                    write(k)
                else
                    write(k, ' ');
                gotoxy(20,6);
                textbackground(0);
                textcolor(15);
                write('                    ');
                gotoxy(20,6);
                write('[', lower(k), ';', upper(k), ']');
            end;
            if ((ord(p) = 75) or (ord(p) = 80)) and (k > 2) then begin
                k := k - 1;
                textbackground(7);
                textcolor(0);
                if k >= 10 then
                    write(k)
                else
                    write(k, ' ');
                gotoxy(20,6);
                textbackground(0);
                textcolor(15);
                write('                    ');
                gotoxy(20,6);
                write('[', lower(k), ';', upper(k), ']');
            end;
        end;
        gotoxy(30,3);
        p := readkey;
    end;
    if ord(p) = 13 then begin
        low := lower(k);
        up := upper(k);
        x1 := 0;
        x2 := 0;
        n := 0;
        cursoron;
        OK := false;
        repeat
            textbackground(0);
            textcolor(15);
            clrscr;
            gotoxy(2,3);
            write('Введите два числа:');
            gotoxy(2,7);
            write('Диапазон чисел: [', low, ';', up, ']');
            gotoxy(2,9);
            write('Перед началом ввода и');
            gotoxy(2,10);
            write('по окончании нажмите Enter');
            textbackground(7);
            textcolor(0);
            gotoxy(34,9);
            write('  OK  ');
            gotoxy(36,10);
            write('  ');
            gotoxy(36,8);
            write('  ');
            gotoxy(34,5);
            write('      ');
            gotoxy(34,3);
            write('      ');
            gotoxy(34,5);
            write(x2);
            gotoxy(34,3);
            write(x1);
            case n of
                0: gotoxy(34,3);
                1: gotoxy(34,5);
                2: gotoxy(36,9);
            end;
            p := readkey;
            if ord(p) = 27 then
                OK := true
            else if ord(p) = 0 then begin
                p := readkey;
                if ord(p) = 80 then
                    n := (n + 1) mod 3
                else if ord(p) = 72 then begin
                    n := n - 1;
                    if n = -1 then
                        n := 2;
                end;
            end else if ord(p) = 13 then
                case n of
                    0: begin 
                        write('      ');
                        gotoxy(34,3);
                        read(x1);
                        if x1 > up then
                            x1 := up;
                        if x1 < low then
                            x1 := low
                    end;
                    1: begin 
                        write('      ');
                        gotoxy(34,5);
                        read(x2);
                        if x2 > up then
                            x2 := up;
                        if x2 < low then
                            x2 := low
                    end;
                    2: OK := true
                end
        until OK;
        cursoroff;
        if ord(p) = 13 then begin
            window(1,1,80,25);
            textbackground(0);
            clrscr;
            window(2,21,36,23);
            textbackground(7);
            clrscr;
            textcolor(0);
            gotoxy(3,2);
            write('Чтобы выйти в меню, нажмите ESC');
            window(1,1,80,25);
            textbackground(0);
            textcolor(15);
            gotoxy(2,6);
            write('2-е:');
            gotoxy(2,8);
            write('б/зн:');
            gotoxy(2,10);
            write('с/зн:');
            gotoxy(8,4);
            write('1-е число');
            gotoxy(8,6);
            binary(x1, up div 2 + 1);
            gotoxy(8,8);
            nosign(x1);
            gotoxy(8, 10);
            sign(x1);
            gotoxy(26,4);
            write('2-е число');
            gotoxy(26,6);
            binary(x2, up div 2 + 1);
            gotoxy(26,8);
            nosign(x2);
            gotoxy(26, 10);
            sign(x2);
            summ(x1, x2, up, low, sds, sdns, CF, OVF, SF, ZF);
            gotoxy(45,4);
            write('Сумма');
            gotoxy(45,6);
            binary(sdns, up div 2 + 1);
            gotoxy(45,8);
            nosign(sdns);
            gotoxy(45,10);
            sign(sds);
            gotoxy(46,13);
            write('CF');
            gotoxy(49,13);
            if CF then
                write('1')
            else
                write('0');
            gotoxy(46,16);
            write('OF');
            gotoxy(49,16);
            if OVF then
                write('1')
            else
                write('0');
            gotoxy(46,19);
            write('SF');
            gotoxy(49,19);
            if SF then
                write('1')
            else
                write('0');
            gotoxy(46,22);
            write('ZF');
            gotoxy(49,22);
            if ZF then
                write('1')
            else
                write('0');
            diff(x1, x2, up, low, sds, sdns, CF, OVF, SF, ZF);
            gotoxy(63,4);
            write('Разность');
            gotoxy(63,6);
            binary(sdns, up div 2 + 1);
            gotoxy(63,8);
            nosign(sdns);
            gotoxy(63,10);
            sign(sds);
            gotoxy(64,13);
            write('CF');
            gotoxy(67,13);
            if CF then
                write('1')
            else
                write('0');
            gotoxy(64,16);
            write('OF');
            gotoxy(67,16);
            if OVF then
                write('1')
            else
                write('0');
            gotoxy(64,19);
            write('SF');
            gotoxy(67,19);
            if SF then
                write('1')
            else
                write('0');
            gotoxy(64,22);
            write('ZF');
            gotoxy(67,22);
            if ZF then
                write('1')
            else
                write('0');
            p := readkey;
            while ord(p) <> 27 do
                p := readkey;
        end;
    end;
end;

procedure tests;
var
    k, i, j: shortint;
    p: char;
    x1, x2, up, low, sign, nsign: longint;
    CFs, OVFs, SFs, ZFs, CFrs, OVFrs, SFrs, ZFrs, OK: boolean;
    CFd, OVFd, SFd, ZFd, CFrd, OVFrd, SFrd, ZFrd: boolean;
    
begin
    k := 2;
    Window(1,1,80,25);
    textbackground(0);
    clrscr;
    Window(19,4,62,16);
    textbackground(7);
    clrscr;
    Window(18,21,63,25);
    clrscr;
    gotoxy(3,2);
    textcolor(0);
    write('Управление производится при помощи стрелок');
    gotoxy(3,4);
    write('Если передумали, нажмите ESC');
    textbackground(0);
    Window(21,5,60,15);
    clrscr;
    textcolor(15);
    gotoxy(4,9);
    write('Для подтверждения нажмите Enter');
    gotoxy(4,6);
    write('Диапазон чисел: [', lower(k), ';', upper(k), ']');
    gotoxy(4,3);
    write('Выберите количество бит: <  >');
    gotoxy(30,3);
    textbackground(7);
    textcolor(0);
    write(k, ' ');
    gotoxy(30,3);
    p := readkey;
    while (ord(p) <> 27) and (ord(p) <> 13) do begin
        if ord(p) = 0 then begin
            p := readkey;
            if ((ord(p) = 77) or (ord(p) = 72)) and (k < 16) then begin
                k := k + 1;
                textbackground(7);
                textcolor(0);
                if k >= 10 then
                    write(k)
                else
                    write(k, ' ');
                gotoxy(20,6);
                textbackground(0);
                textcolor(15);
                write('                    ');
                gotoxy(20,6);
                write('[', lower(k), ';', upper(k), ']');
            end;
            if ((ord(p) = 75) or (ord(p) = 80)) and (k > 2) then begin
                k := k - 1;
                textbackground(7);
                textcolor(0);
                if k >= 10 then
                    write(k)
                else
                    write(k, ' ');
                gotoxy(20,6);
                textbackground(0);
                textcolor(15);
                write('                    ');
                gotoxy(20,6);
                write('[', lower(k), ';', upper(k), ']');
            end;
        end;
        gotoxy(30,3);
        p := readkey;
    end;
    if ord(p) = 13 then begin
        low := lower(k);
        up := upper(k);
        cursoron;
        textbackground(0);
        textcolor(15);
        clrscr;
        gotoxy(2,2);
        write('Тесты можно решать в неограниченном');
        gotoxy(2,3);
        write('количестве. За каждый правильный');
        gotoxy(2,4);
        write('ответ вы получаете очко. При возврате');
        gotoxy(2,5);
        write('в меню счет не сбрасывается');
        gotoxy(2,7);
        write('Перемещение - стрелки');
        gotoxy(2,8);
        write('Смена флага - TAB');
        gotoxy(6,10);
        write('Для продолжения нажмите Enter');
        p := readkey;
        while (ord(p) <> 13) and (ord(p) <> 27) do
            p := readkey;
        if ord(p) = 13 then begin
            OK := false;
            repeat
                window(1,1,80,25);
                textbackground(0);
                clrscr;
                window(1,23,80,25);
                textbackground(7);
                textcolor(0);
                clrscr;
                gotoxy(3,2);
                write(score, '/', maxscore);
                gotoxy(20,2);
                write('Нажмите ESC, чтобы выйти. Enter, чтобы подтвердить');
                window(1,1,80,25);
                textbackground(0);
                textcolor(15);
                randomize;
                x1 := random(up - low + 1) + low;
                x2 := random(up - low + 1) + low;
                summ(x1,x2,up,low,sign,nsign,CFrs,OVFrs,SFrs,ZFrs);
                diff(x1,x2,up,low,sign,nsign,CFrd,OVFrd,SFrd,ZFrd);
                CFs := false;
                OVFs := false;
                SFs := false;
                ZFs := false;
                CFd := false;
                OVFd := false;
                SFd := false;
                ZFd := false;
                gotoxy(4,4);
                write('1-е число - ', x1);
                gotoxy(4,6);
                write('2-е число - ', x2);
                gotoxy(29,2);
                write('Сумма     Разность');
                gotoxy(29,4);
                write('CF 0      CF 0');
                gotoxy(29,7);
                write('OF 0      OF 0');
                gotoxy(29,10);
                write('SF 0      SF 0');
                gotoxy(29,13);
                write('ZF 0      ZF 0');
                gotoxy(32,4);
                i := 0;
                j := 0;
                p := readkey;
                while (ord(p) <> 27) and (ord(p) <> 13) do begin
                    if ord(p) = 9 then begin
                        if i = 0 then
                            case j of
                                0: begin
                                    CFs := not CFs;
                                    gotoxy(32,4);
                                    if CFs then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                1: begin
                                    OVFs := not OVFs;
                                    gotoxy(32,7);
                                    if OVFs then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                2: begin
                                    SFs := not SFs;
                                    gotoxy(32,10);
                                    if SFs then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                3: begin
                                    ZFs := not ZFs;
                                    gotoxy(32,13);
                                    if ZFs then
                                        write('1')
                                    else
                                        write('0');
                                end;
                            end
                        else if i = 1 then
                            case j of
                                0: begin
                                    CFd := not CFd;
                                    gotoxy(42,4);
                                    if CFd then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                1: begin
                                    OVFd := not OVFd;
                                    gotoxy(42,7);
                                    if OVFd then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                2: begin
                                    SFd := not SFd;
                                    gotoxy(42,10);
                                    if SFd then
                                        write('1')
                                    else
                                        write('0');
                                end;
                                3: begin
                                    ZFd := not ZFd;
                                    gotoxy(42,13);
                                    if ZFd then
                                        write('1')
                                    else
                                        write('0');
                                end;
                            end
                    end else if ord(p) = 0 then begin
                        p := readkey;
                        if ord(p) = 72 then begin
                            j := j - 1;
                            if j = -1 then
                                j := 3;
                        end;
                        if ord(p) = 80 then
                            j := (j + 1) mod 4;
                        if (ord(p) = 75) or (ord(p) = 77) then
                            i := (i + 1) mod 2;
                        if i = 0 then
                            case j of
                                0: gotoxy(32,4);
                                1: gotoxy(32,7);
                                2: gotoxy(32,10);
                                3: gotoxy(32,13);
                            end
                        else if i = 1 then
                            case j of
                                0: gotoxy(42,4);
                                1: gotoxy(42,7);
                                2: gotoxy(42,10);
                                3: gotoxy(42,13);
                            end
                    end;
                    p := readkey;
                end;
                if ord(p) = 27 then
                    OK := true
                else if ord(p) = 13 then begin
                    textbackground(7);
                    textcolor(0);
                    gotoxy(35,4);
                    if CFs = CFrs then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(35,7);
                    if OVFs = OVFrs then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(35,10);
                    if SFs = SFrs then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(35,13);
                    if ZFs = ZFrs then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    
                    gotoxy(45,4);
                    if CFd = CFrd then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(45,7);
                    if OVFd = OVFrd then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(45,10);
                    if SFd = SFrd then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    gotoxy(45,13);
                    if ZFd = ZFrd then begin
                        write(' 1 ');
                        score := score + 1
                    end else
                        write(' 0 ');
                    maxscore := maxscore + 8;
                    p := readkey;
                    if ord(p) = 27 then
                        OK := true;
                end;
            until OK;
            cursoroff;
        end;
    end;
end;

procedure information;
begin
    window(1,1,80,25);
    textbackground(0);
    textcolor(15);
    clrscr;
    gotoxy(3,3);
    write('Надеюсь, что вам понравилась моя программа');
    gotoxy(3,5);
    write('Made by Зянчурин Игорь from 110 группа');
    gotoxy(3,7);
    write('ВМК МГУ 2021 год');
    gotoxy(3,9);
    if maxscore = 0 then begin
        write('Кстати, вы так и не прошли ни один тест :(');
        gotoxy(3,11);
        write('Попробуйте, и вернитесь сюда, пожалуйста');
    end else begin
        write('Ура! Вы набрали ', score, ' из ', maxscore, ' очков!');
        gotoxy(3,11);
        write('Честно говоря, это лучший результат');
        gotoxy(3, 13);
        write('Спасибо, что уделили время на просмотр моей программы :)');
    end;
    gotoxy(3, 15);
    write('Кстати, попробуйте сломать программу (только не выходите за longint :()');
    gotoxy(5,18);
    write('Вы можете нажать ESC, чтобы выйти в меню');
    p := readkey;
    while ord(p) <> 27 do
        p := readkey
end;

begin
    score := 0;
    maxscore := 0;
    repeat
        again := true;
        cursoroff;
        Window(1,1,80,25);
        textbackground(7);
        textcolor(15);
        clrscr;
        Window(1,1,80,14);
        textbackground(0);
        clrscr;
        Window(3,16,78,24);
        clrscr;
        Window(1,1,80,25);
        gotoxy(13,5);
        write('Учебная программа по расстановке флагов');
        gotoxy(13,7);
        write('Перемещение по меню осуществляется при помощи стрелок');
        gotoxy(13,9);
        write('После выбора, нажмите Enter');
        gotoxy(4,19);
        write('Тестирование');
        gotoxy(4,21);
        write('Информация');
        gotoxy(4,23);
        write('Выход');
        n := 0;
        textbackground(7);
        textcolor(0);
        gotoxy(4,17);
        write('Калькулятор');
        p := readkey;
        while ord(p) <> 13 do begin
            if ord(p) = 0 then begin
                p := readkey;
                if ord(p) = 80 then begin
                    n := (n + 1) mod 4;
                    case n of
                        0: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,23);
                            write('Выход');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,17);
                            write('Калькулятор');
                        end;
                        1: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,17);
                            write('Калькулятор');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,19);
                            write('Тестирование');
                        end;
                        2: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,19);
                            write('Тестирование');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,21);
                            write('Информация');
                        end;
                        3: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,21);
                            write('Информация');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,23);
                            write('Выход');
                        end;
                    end;
                end;
                if ord(p) = 72 then begin
                    n := n - 1;
                    if n = -1 then
                        n := 3;
                    case n of
                        0: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,19);
                            write('Тестирование');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,17);
                            write('Калькулятор');
                        end;
                        1: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,21);
                            write('Информация');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,19);
                            write('Тестирование');
                        end;
                        2: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,23);
                            write('Выход');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,21);
                            write('Информация');
                        end;
                        3: begin
                            textbackground(0);
                            textcolor(15);
                            gotoxy(4,17);
                            write('Калькулятор');
                            textbackground(7);
                            textcolor(0);
                            gotoxy(4,23);
                            write('Выход');
                        end;
                    end;
                end;
            end;
            p := readkey
        end;
        case n of
            0: calculator;
            1: tests;
            2: information;
            3: again := false;
        end;
    until not again;
    textbackground(0);
    clrscr
end.
