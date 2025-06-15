procedure calcularHistograma(pal : Palabra; var hist : Histograma);
{ 1 - Retorna en `hist` el histograma de `pal`, es decir la cantidad
 de ocurrencias de cada letra en esa palabra.
No se puede asumir el estado inicial de histograma. }
var i : integer;
begin
    for i := 1 to pal.tope do
    begin
        hist[pal.cadena[i]] := hist[pal.cadena[i]] + 1;
    end;
end;

function iguales(pal1, pal2 : Palabra) : boolean;
{ 2 - Dadas dos palabras, `pa1` y `pal2`, verifica si son iguales. }
begin
    iguales := (pal1.tope = pal2.tope) and (pal1.cadena = pal2.cadena)
end;

procedure calcularHistogramaTexto(tex : Texto; var hist : Histograma);
{ 3 - Retorna en `hist` la cantidad de ocurrencias de cada letra en el texto `tex`.
No se puede asumir el estado inicial de `hist`.  
   Texto	= ^NodoPal; 
   NodoPal	= record  
      info : Palabra;
      sig  : Texto
   end;
   procedure calcularHistograma(pal : Palabra; var hist : Histograma);
{ 1 - Retorna en `hist` el histograma de `pal`, es decir la cantidad
 de ocurrencias de cada letra en esa palabra.
No se puede asumir el estado inicial de histograma. 
var i : integer;
begin
    for i := 1 to pal.tope do
    begin
        hist[pal.cadena[i]] := hist[pal.cadena[i]] + 1;
    end;
end;
   }
var i : integer;
begin
    for i := 1 to tex^.info.tope do
    begin
        hist[tex^.info.cadena[i]] := 0; // Inicializar el histograma
    while (tex <> nil) do
    begin
        calcularHistograma(tex^.info, hist);
    end;
    tex := tex^.sig;
    end;
end;

function esPalabraValida(pal : Palabra; dicc : Texto) : boolean;
{ 4 - Dada una palabra `pal` y un diccionario `dicc`, verifica si la palabra
está en el texto dicc. 
   Texto	= ^NodoPal; 
   NodoPal	= record  
      info : Palabra;
      sig  : Texto
   end;}
begin
    esPalabraValida := false; 
    while (dicc <> nil) do 
    begin
        if iguales(pal, dicc^.info) then
        begin
            esPalabraValida := true;
        end;
        dicc := dicc^.sig;
    end;
end;

procedure removerLetraAtril(var mano : Atril; let : char);
{ 5 - Dada una letra `let`, elimina la primera aparición de esta
 del atril y deja a su lugar la última letra del atril.
Se asume que la letra está en el atril. }
begin
end;

function entraEnTablero(pal : Palabra; pos : Posicion) : boolean;
{ 6 - Verifica si la palabra `pal` entra en el tablero a partir de la posición `pos`,
teniendo en cuenta que no debe salirse de los límites del tablero. } 
begin
    entraEnTablero := false;
    if (pos.direccion = Horizontal) then
        entraEnTablero := (pos.col + pal.tope - 1<= MAXCOLUMNAS)
    else if (pos.direccion = Vertical) then
        entraEnTablero := (Ord(pos.fila) + pal.tope - 1 <= Ord(MAXFILAS))
end;

procedure siguientePosicion(var pos : Posicion);
{ 7 - Actualiza la posición `pos`, devuelve en la misma variable la posición del 
 siguiente casillero en la dirección indicada en `pos`. 
 Se asume que `pos` no corresponde a la última fila si la dirección es vertical, 
 ni a la última columna si la dirección es horizontal. }
begin
end;

function puedeArmarPalabra(pal : Palabra; pos : Posicion; mano : Atril; tab : Tablero) : boolean;
{ 8 - Verifica que la palabra `pal` puede armarse a partir de la posición `pos`, 
 considerando las letras disponibles en el atril y en el tablero (respetando su ubicación).
 Se puede asumir que la palabra entra en el tablero. }
begin
end;

procedure intentarArmarPalabra(pal : Palabra; pos : Posicion; 
                              var tab : Tablero; var mano : Atril; 
                              dicc : Texto; info : InfoFichas; 
                              var resu : ResultadoJugada);
{ 9 - Dada una palabra, posición, tablero, atril, diccionario, info y un resultado.}
{ En primer lugar, se verifica que la palabra entre en el tablero dada la posición. }
{ Luego que se pueda armar la palabra en el tablero con las fichas disponibles }
{ y por último que la palabra exista en el diccionario. }
{ Si es posible armar la palabra, esta se agrega en el tablero, actualiza `resu.tipo` y 
almacena el puntaje en `resu.puntaje`.
Para calcular el puntaje, se suman los puntos de las letras **agregadas**, utilizando 
la información de `info` y la bonificación del casillero. Tanto para el puntaje calculado
como para las bonificaciones **NO** suman las letras ya existentes en el tablero que conforman la palabra. 
Si no se puede armar la palabra, devuelve el resultado correspondiente en `resu.tipo`. }
begin
end;

procedure registrarJugada(var jugadas : HistorialJugadas; pal : Palabra; pos : Posicion; puntaje : integer);
{ 10 - Dada una lista de jugadas, una palabra, Posicion y puntaje, agrega la jugada al final de la lista }
begin
end;