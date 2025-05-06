program Fecha;

var 
    t1, t2, hh, d, mm, totalTime : integer;
    
begin
read(t1, t2);
totalTime := 
    (t1 div 100) * 60 + (t1 mod 100) +
    (t2 div 100) * 60 + (t2 mod 100);

d :=  totalTime div 1440;           {días completos}
  totalTime:= totalTime mod 1440;     {min restantes del último día}

hh := totalTime div 100;
mm := totalTime mod 100;

writeln(d, ' ', hh, mm)
end.




  h       := totalMin div 60;       {horas restantes}
  m       := totalMin mod 60;       {minutos restantes}
  hhmm    := h * 100 + m;           {reconstruye hhmm}

  writeln(d, ' ', hhmm);            {ej.: 1 1138}
end.


