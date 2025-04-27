PROGRAM areaTriangulo;

VAR
    a, b, c: Integer;
    area, s: Real;
BEGIN
    readLn(a, b, c);
    s := (a + b + c) / 2;
    area := sqrt(s * (s - a) * (s - b) * (s - c));
    writeLn(area)
END.


