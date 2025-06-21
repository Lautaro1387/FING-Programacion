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
var i : integer;
begin
    if (pal1.tope <> pal2.tope) then
    begin
        iguales := false;
    end
    else
    begin
        iguales := true;
        for i := 1 to pal1.tope do
        begin
            if (pal1.cadena[i] <> pal2.cadena[i]) then
            begin 
                iguales := false; 
            end;
        end;
    end;
end;

procedure calcularHistogramaTexto(tex : Texto; var hist : Histograma);
{ 3 - Retorna en `hist` la cantidad de ocurrencias de cada letra en el texto `tex`.
No se puede asumir el estado inicial de `hist`.  }
   var i : char;
begin
    for i := 'a' to 'z' do
        hist[i] := 0;
    while (tex <> nil) do
    begin
        calcularHistograma(tex^.info, hist);
        tex := tex^.sig;
    end;
end;

function esPalabraValida(pal : Palabra; dicc : Texto) : boolean;
{ 4 - Dada una palabra `pal` y un diccionario `dicc`, verifica si la palabra
está en el texto dicc. }
begin
    esPalabraValida := false; 
    while (dicc <> nil) do
    begin
        if iguales(pal, dicc^.info) then
        begin
            esPalabraValida := true;
            dicc := nil
        end
        else
            dicc := dicc^.sig
    end;
end;

procedure removerLetraAtril(var mano : Atril; let : char);
{ 5 - Dada una letra `let`, elimina la primera aparición de esta
 del atril y deja a su lugar la última letra del atril.
Se asume que la letra está en el atril.  }
var i : integer;
begin
    i := 1;
    while i <= mano.tope do
    begin
        if mano.letras[i] = let then
        begin
            mano.letras[i] := mano.letras[mano.tope];
            mano.tope := mano.tope - 1;
            i := mano.tope + 1; { salgo del bucle }
        end
        else
            i := i + 1;
    end;
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
 ni a la última columna si la dirección es horizontal. 
 
 Tablero = array['A'..MAXFILAS, 1..MAXCOLUMNAS] of Casillero;

   TipoDireccion = (Horizontal, Vertical);
   { Posicion de la palabra 
   Posicion = record
      direccion : TipoDireccion;
      fila : 'A'..MAXFILAS;
      col  : 1..MAXCOLUMNAS;
   end;
 }
begin
    if (pos.direccion = Horizontal) then
        pos.col := pos.col + 1
    else
        pos.fila := succ(pos.fila);
end;

function puedeArmarPalabra(pal : Palabra; pos : Posicion;
                           mano : Atril;  tab : Tablero) : boolean;
var
   i, j          : integer;
   posAux        : Posicion;
   manoAux       : Atril;
   ok, encontrada: boolean;
begin
   ok      := entraEnTablero(pal, pos);
   posAux  := pos;
   manoAux := mano;
   i       := 1;

   while (i <= pal.tope) and ok do
   begin
      encontrada := false;

      { casillero ocupado }
      if tab[posAux.fila, posAux.col].ocupada then
      begin
         if tab[posAux.fila, posAux.col].ficha = pal.cadena[i] then
            encontrada := true;
      end
      { casillero libre}
      else
      begin
         j := 1;
         while (j <= manoAux.tope) and (not encontrada) do
         begin
            if manoAux.letras[j] = pal.cadena[i] then
            begin
               removerLetraAtril(manoAux, pal.cadena[i]);
               encontrada := true
            end
            else
               j := j + 1;  { sigo buscando }
         end;
      end;
      ok := encontrada;
      if ok and (i < pal.tope) then
         siguientePosicion(posAux);
      i := i + 1;
   end;

   puedeArmarPalabra := ok;
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
Si no se puede armar la palabra, devuelve el resultado correspondiente en `resu.tipo`.

   TipoResultado = (Valida, NoEntra, NoFichas, NoExiste);
  Letra        = 'a' .. 'z';
   Palabra	= record
      cadena : array [1 .. MAXPAL] of Letra;
      tope   : 0 .. MAXPAL
   end; 


   InfoFicha = record
      puntaje : integer;
      cantidad : integer;
   end;

   InfoFichas = array[Letra] of InfoFicha;

   TipoBonus = (Ninguno, DobleLetra, TriplePalabra, Trampa);
    tipo de los bonos 

   Casillero = record
      bonus : TipoBonus;
      case ocupada : boolean of
         true : (ficha : Letra);
         false : ();  si no está ocupada, no hay letra 
   end;

   // lista de palabras, que representa a un texto 
   Texto	= ^NodoPal; 
   NodoPal	= record  
      info : Palabra;
      sig  : Texto
   end;

   Tablero = array['A'..MAXFILAS, 1..MAXCOLUMNAS] of Casillero;

   TipoDireccion = (Horizontal, Vertical);
                         // Posicion de la palabra 
   Posicion = record
      direccion : TipoDireccion;
      fila : 'A'..MAXFILAS;
      col  : 1..MAXCOLUMNAS;
   end;

   ResultadoJugada = record
      palabra : Palabra;
      pos : Posicion;
      case tipo : TipoResultado of
         Valida : (puntaje : integer);
         NoEntra : ();
         NoFichas : ();
         NoExiste  : ();
   end;
}
var i, puntajeLetra : integer;
    posTemp: Posicion;
    triple : integer;
begin
    resu.tipo := Valida;
    resu.puntaje := 0;
    resu.palabra := pal;
    resu.pos := pos;
    posTemp := pos;
    triple := 1;
    if not entraEnTablero(pal, posTemp) then
        resu.tipo := NoEntra
    else if not puedeArmarPalabra(pal, posTemp, mano, tab) then
        resu.tipo := NoFichas
    else if not esPalabraValida(pal, dicc) then
        resu.tipo := NoExiste
    else
    begin
        for i := 1 to pal.tope do
        begin
            if not tab[posTemp.fila, posTemp.col].ocupada then
            begin
                puntajeLetra := info[pal.cadena[i]].puntaje;

                case tab[posTemp.fila, posTemp.col].bonus of
                    Ninguno: puntajeLetra := puntajeLetra;
                    DobleLetra: puntajeLetra := puntajeLetra * 2;
                    TriplePalabra: triple := triple * 3;
                    Trampa: 
                        begin
                            resu.puntaje := resu.puntaje - puntajeLetra;
                            puntajeLetra := 0; // No se suma puntaje por la trampa
                        end;
                end;
                tab[posTemp.fila, posTemp.col].ficha   := pal.cadena[i];
                tab[posTemp.fila, posTemp.col].ocupada := true;
                removerLetraAtril(mano, pal.cadena[i]);
                resu.puntaje := resu.puntaje + puntajeLetra;
            end;
            if i < pal.tope then
            { Si no es la última letra, se pasa a la siguiente posición }
                siguientePosicion(posTemp);
        end;
             resu.puntaje := resu.puntaje * triple;

    end;
end;


procedure registrarJugada(var jugadas : HistorialJugadas; pal : Palabra; pos : Posicion; puntaje : integer);
{ 10 - Dada una lista de jugadas, una palabra, Posicion y puntaje, agrega la jugada al final de la lista 

   HistorialJugadas = ^NodoJugada;
   NodoJugada = record
      palabra : Palabra;
      pos : Posicion;
      puntaje : integer;
      sig : HistorialJugadas
   end;
}
var nuevo : HistorialJugadas;
    cursor : HistorialJugadas;
begin
    new(nuevo);
    nuevo^.sig := nil; { El nuevo nodo no apunta a nada }
    nuevo^.palabra := pal; { Asigna la palabra a la jugada }
    nuevo^.pos := pos; { Asigna la posición a la jugada }
    nuevo^.puntaje := puntaje; { Asigna el puntaje a la jugada }
    if jugadas = nil then
    begin
        jugadas := nuevo;
    end
    else
    begin
        cursor := jugadas;
        while (cursor^.sig <> nil) do
            cursor := cursor^.sig;
    cursor^.sig := nuevo; { Asigna el siguiente nodo al cursor }
    end;
    nuevo^.sig := nil; { El nuevo nodo no apunta a nada }
    nuevo^.palabra := pal; { Asigna la palabra a la jugada }
    nuevo^.pos := pos; { Asigna la posición a la jugada }
    nuevo^.puntaje := puntaje; { Asigna el puntaje a la jugada }
end;
