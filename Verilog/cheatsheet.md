--- 
author: 
  - "Leonardo Scoppitto"
classoption: a4paper
date: "October 2020"
documentclass: article
fontsize: 12pt
geometry: "left=3.5cm,right=3cm,top=3cm,bottom=3cm"
output: pdf_document
title: Verilog
---

# Introduzione

Il verilog, come gli altri linguaggi **RTL** (Register Transfer Language), è un linguaggio per la descrizione dell'hardware che permette di definre componenti che calcolano funzioni, con o senza stato, per poi essere utilizzati come moduli in altri componenti.

# Tipi di dati

## Costanti (Literal)

I numeri si possono rappresentare specificando la base e il numero di bit con la notazione:
 ```verilog
<n>'<b>xxxx
 ```
 Dove:

 * *n* rappresenta il numero di bin in decimale

 * *b* è un carattere che rappresenta la base (*d* per decimale, *b* per binario, *o* per ottale e *h* per esadecimale)

 Quindi un esempio può essere: `4'b1001` è 9 in binario su 4 bit.

 ## Wire


Letteralmente *fili*, sono variabili usate per realizzare i collegamenti fra i *module*.\
se ho un wire di più di un bit posso usare la notazione `wire[0:x]` o `wire[x:0]` per rappresentare un array di wire dal primo, rispettivamente va da `0` a `x` o da `x` a `0` (quindi di `x+1` bit e il primo numero è il più significativo).

## Registri

I registri `reg` hanno la stessa sintassi dei wire e hanno dimensione un bit. Vengono considerati unsigned

## Array

Si può usare le parentesi quadre dopo il nome della variavile per creare array di registri, quindi `reg[7:0]arr[256]` è un array di 256 registri da 8 bit.

## Integer 

Le variabili `integer` sono variabili generiche di tipo `reg` e vengon interpretate come interi con segno.

# Operatori

Fondamentalmente quelli visti in C tranne che per `~` che rappresenta il NOT bit a bit.\
Gli if statement si fanno in forma ridotta come in C.\
L'operatore `#x` sta a significare che per *x* istanti di tempo il comando è valido. Se non esprimo comandi aspetto *x* tempo prima di andare avanti come se fosse uno sleep.

# Moduli

Un modulo è un componente che fa qualcosa con dei dati in input per restituire un output:
```verilog
module nome_modulo(output nome_output, input nome input)

    corpo del modulo

endmodule
```
`parameter` è il `#define` del C.

## Blocchi di comandi

All'interno di un modulo posso definire due tipi di blocchi di comadi:

* `initial` Per dire che quel blocco deve essere eseguito solo all'inizio della simulazione

* `always` l'equivlente del `while(true)`

Sintassi:
```verilog
initial/always
    begin
        ...
        do someting
        ...
    end
```
Nel caso di `always` posso associare dei modificatori come `@ (lista di variavili)` (sensitivity list) col significato di far eseguire il blocco ogni volta che una delle variabili della lista cambia di valore.
Se la variabile è preceduta dalla dicitura `negedge` o `posedge` si esegue il blocco ogni colta che la viabile passa, rispettivamente, da 1 a 0 o da 0 a 1.

## Assegnamento

L'assegnamento si divide in:

* Bloccante: termina prima dello statement successivo e si esegue semplicemente scrivendo `x = something`

* Non bloccante: tutto il processo di assegnamento avviene istantaneamente (calcolo e lettura delle r_values). Ad esemprio il seguente codice produce uno scambio di variabili
```verilog
x <= y;
y <= x;
``` 

Per quanto riguarda i cicli sono esattamente identici al C, tranne che per la variabile i incremento (`i = i + 1`, invece di i++) e per la dichiarazione del `begin` e dell'`end` del blocco.\
L'`if-else` è classico senza obbligo di `else` e lo switch ha gli identificatori `begin-end` per ogni caso.

# Direttive

Le direttive iniziano con `$` e permettono di salvare la traccia della simulazione/stampare a schermo il risultato e altre cose carine:

* `$dumpfile("Nome file")` permette di salvare tutte le variabili in un file

* `$dumpvars` per salvare anche i valori delle variabili

* `$time` restituisce il valore del tempo corrente

* `$display(formato, listavariabili)` è l'equivalente del `printf`

* `$monitor` è come display ma refresha la variabile ogni volta che cambia


