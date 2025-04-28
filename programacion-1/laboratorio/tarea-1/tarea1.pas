procedure siguienteDigito(var num: Natural; var digito: integer);
begin
    digito := num mod 10;
    num := num div 10;
end;

function esHistogramaDe(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9: integer; num: Natural): boolean;
var
    a0, a1, a2, a3, a4, a5, a6, a7, a8, a9 : integer;
    digit: integer;
begin
    a0 := c0; a1 := c1; a2 := c2; a3 := c3; a4 := c4; a5 := c5; a6 := c6; a7 := c7; a8 := c8; a9 := c9;
    if num = 0 then
        a0 := a0 - 1
    else
    while num > 0 do
    begin
        digit := num mod 10;
        case digit of
        0: a0 := a0 - 1;
        1: a1 := a1 - 1;
        2: a2 := a2 - 1;
        3: a3 := a3 - 1;
        4: a4 := a4 - 1;
        5: a5 := a5 - 1;
        6: a6 := a6 - 1;
        7: a7 := a7 - 1;
        8: a8 := a8 - 1;
        9: a9 := a9 - 1;
        end;
        num := num div 10;
    end;              
        esHistogramaDe :=
            (a0 = 0) and (a1 = 0) and
            (a2 = 0) and (a3 = 0) and
            (a4 = 0) and (a5 = 0) and
            (a6 = 0) and (a7 = 0) and
            (a8 = 0) and (a9 = 0);
end;
function sonAnagramas(num1, num2: Natural): boolean;
var
  a0,a1,a2,a3,a4,a5,a6,a7,a8,a9 : integer;
  dig, tmp : Natural;
begin
  {1. inicializar en 0}
  a0:=0; a1:=0; a2:=0; a3:=0; a4:=0;
  a5:=0; a6:=0; a7:=0; a8:=0; a9:=0;

  {2. contar las cifras de num1}
  tmp := num1;
  if tmp = 0 then
    a0 := 1
  else
    while tmp > 0 do
    begin
      dig := tmp mod 10;
      case dig of
        0: a0 := a0 + 1;
        1: a1 := a1 + 1;
        2: a2 := a2 + 1;
        3: a3 := a3 + 1;
        4: a4 := a4 + 1;
        5: a5 := a5 + 1;
        6: a6 := a6 + 1;
        7: a7 := a7 + 1;
        8: a8 := a8 + 1;
        9: a9 := a9 + 1;
      end;
      tmp := tmp div 10;
    end;               { ← cierra el while }

  {3. usar esHistogramaDe para comparar con num2 }
  sonAnagramas :=
    esHistogramaDe(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9, num2);
end;
