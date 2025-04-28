

## Cómo ejecutar los casos de prueba de la Primera Tarea

**Nota:**  Este test debe ser ejecutado en linux.

En esta página se describen varios archivos que sirven para probar la tarea.
Estos están comprimidos en el archivo `pruebas.tar.gz` (se encuentra en la
sección de laboratorio del curso).

***El contenido del archivo comprimido se debe extraer en una carpeta cualquiera
y en la misma se debe copiar el archivo `tarea1.pas` con los subprogramas
solicitados en esta tarea.***

## Como descomprimir los archivos

El archivo se puede descomprimir con el siguiente comando: 
`tar xzf pruebas.tar.gz`. También funciona accionar con doble click sobre el archivo.

## Archivos proporcionados

En la carpeta donde se realizó la descompresión se van a encontrar los
siguientes archivos y carpetas:

-    Los archivos `definiciones.pas` y `principal.pas`.
-    Una carpeta  `entradas` que contiene las entradas al programa principal
     para realizar los casos de prueba.
-    Una carpeta  `salidas` con las salidas oficiales, o esperadas.
-    Una carpeta  `mios` con las salidas que se obtienen al ejecutar el
     programa.
-    Un script Python `test.py` para compilar, ejecutar y comparar los casos de prueba automáticamente.

## Comportamiento del programa principal

 Para probar el programa, compilamos el programa `principal.pas`. Esto se hace una sola vez mientras no se hagan cambios.

```bash
    fpc -Co -Cr -Miso -gl principal.pas
```

y nos aseguramos que no hay errores de compilación y que se ha generado el ejecutable llamado `principal`.

Se debe compilar en **línea de comandos**.

Principal invoca a los subprogramas implementados por el estudiante e implementa la entrada-salida por línea de comandos. Este es útil para verificar el correcto funcionamiento de cada función o procedimiento pedido.

## Probando de manera interactiva

El programa se puede ejecutar de manera interactiva con el comando:

```bash
    ./principal
```

En esta modalidad el programa imprime el mensaje:



```bash
--------------------------------
Ingrese Opción
--------------------------------
0=Fin
1=Extraer último dígito
2=Chequear histograma
3=Chequear anagramas
--------------------------------
```
Y queda esperando que se ingrese una de las opciones. A continuación, se detalla el comportamiento para cada una:

### Opción 1 – Extraer último dígito

El programa solicita:

```bash
Ingrese un número: 
```
Luego de ingresar un número natural, se imprime el último dígito y el número sin ese dígito.

Ejemplo:

```bash
Ingrese un número: 459
Último dígito: 9
Número sin el último dígito: 45
```
### Opción 2 – Chequear histograma

Se solicita un número y luego la cantidad de ocurrencias esperadas para cada dígito del 0 al 9:


```bash
Ingrese la cantidad de ocurrencias de cada uno de los siguentes dígitos
0 1 2 3 4 5 6 7 8 9:
0 1 2 2 0 0 0 0 0 0
Ingrese el número a evaluar: 
13322
```
El programa compara si las cantidades coinciden con las del número ingresado e informa el resultado:

```bash
Es histograma.
```
o bien

```bash
No es histograma.
```

### Opción 3 – Chequear anagramas

El programa solicita dos números:

```bash
Ingrese dos números: 
123 321
```
Y determina si son anagramas (es decir, si están compuestos por los mismos dígitos):

```bash
Son anagramas.
```
o, en caso contrario:

```bash
No son anagramas.
```
### Opción 0 – Finalizar
Ingresando la opción 0, el programa imprime:

```bash
Ejecución finalizada.
```
y termina su ejecución.


## Probando un Caso de Prueba

Si queremos probar un caso de prueba particular, por ejemplo  `1_01.txt`, procedemos así:

Ejecutamos nuestro programa de la siguiente forma:

```bash
     ./principal  < entradas/1_01.txt  > mios/1_01.txt
```

El comando anterior ejecuta el programa principal de manera tal que la entrada
es leída desde el archivo `entradas/1_01.txt` y la salida es guardada en el
archivo `mios/1_01.txt`.

Luego se verifica que la salida obtenida coincida con la salida esperada
ejecutando el comando:

```bash
     diff  mios/1_01.txt  salidas/1_01.txt 
```

Si no hay diferencias entre los archivos `mios/1_01.txt` y `salidas/1_01.txt` el comando no emite ninguna salida. Eso significa que el test es correcto para el
caso 01.

En cambio, si el comando `diff` emite alguna salida, el test es incorrecto. Para
conocer la diferencia recomendamos mirar (*a ojo*) el contenido de los archivos
`mios/1_01.txt` y `salidas/1_01.txt`. El primero es el resultado desplegado por el
programa del estudiante y el segundo el resultado correcto.

## Verificando todos los casos

Adjuntamos además un script de *Python* que permite ejecutar automáticamente
todos los casos y nos indica para cada test si es correcto o no. El test se
ejecuta de la siguiente manera en la terminal:

```python
    python3 test.py
```

Este comando: compila el programa principal, ejecuta cada uno de los casos de
prueba de la carpeta `entradas`, y compara cada resultado obtenido con la salida
esperada que está en la carpeta `salidas`.  
Las salidas quedan en la carpeta `mios`.  
Además en la pantalla se indica el resultado al ejecutar cada caso y al final se
informa la cantidad de casos correctos e incorrectos.

## Descarga de Archivos

El archivo `pruebas.tar.gz` se puede descargar de la sección de Laboratorio del
EVA del curso.
