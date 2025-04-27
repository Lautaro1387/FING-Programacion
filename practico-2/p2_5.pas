program charOrd;

var
  a, b, c, d : char;
  r1, r2     : integer;
  resu       : real;

begin
  read(a, b, c, d);

  r1  := ord(a) - ord('0');                             { dígito de las decenas }
  r2  := (ord(c) - ord('0')) * 10 + (ord(d) - ord('0'));{ parte decimal }
  resu := r1 + r2 / 100;                                { número construido }

  writeln('Valor ingresado: ', resu:4:2);
end.
