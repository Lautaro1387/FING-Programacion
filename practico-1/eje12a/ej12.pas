PROGRAM periodoPendulo;
CONST
    pi = 3.14;
    g = 9.8;
VAR
    l, t: Real;
BEGIN
    readLn (l);
    t := 2 * pi * sqrt(l/g);
    writeLn(l, t)
END.

