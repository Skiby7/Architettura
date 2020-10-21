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

# Reti Combinatorie

Le reti combinatorie implementano *funzioni pure*, ovvero senza stato, perciò per ogni configurazione di `0` e `1` in entrata è prevista una e una sola configurazione in uscita.\
Ci sono due modi di implementare le reti combinatorie:

* Utilizzo moduli di tipo `primitive`, che hanno nel corpo la definizione della tabella di verità del componente, che però è limitata a 1 bit in uscita

* Utilizzo un modulo di tipo `module` che incapsula in un programma verilog il comportamento (metodo behavioural) del componente. Non ho limiti di bit in input output

## Dichiarazione di un modulo

La dichiarazione di un `module` o di una `primitive` fa due scopi fondamentali:

1. Definire l'interfaccia e quindi come il modulo agisce col mondo esterno.

2. Definire la logica e quindi specificare il comportamento interno del modulo in modo *behavioural* o strutturale.

## Moduli primitive

Questi moduli si definiscono con una sequenza dei comandi:

```verilog
primitive nome_primitiva(output z, input x,input y)

    table
        0 0 : 1;
        0 1 : 0;
        1 0 : 0;    
        1 1 : 1;
    endtable

endprimitive
```

In questo caso ho in ingresso due registri da 1 bit e ne restituisco uno da 1 bit.\
Le colonne degli input rappresentano gli input nell'ordine in cui vengono dichiarati nell'intestazione 

## Moduli behavioural

In questo caso ho una sequenza di comandi `module` `endmodule` e all'interno specifico il comportamento della rete tramite un'espressione booleana tramite un `assign` alla l-value (output), una combinazione dei parametri in input:

```verilog
module confrontatore(output z, input x, input y)

    assign
        z = !x & !y | x & yò

endmodule
```

Nell'ordine eseguo $not\rightarrow and \rightarrow or$.\
Ricorda che: 
* $! \rightarrow negazione\text{ }logica$ 

* $\sim\text{ } \rightarrow negazione \text{ } bit \text{ } a \text{ } bit$

# Reti Sequenziali


Le reti sequenziali servono a implementare automi mediante: 

* Reti di Mealy in cui le uscite e il nuovo stato sono funzione sia degli ingressi che dello stato corrente

* Reti di Moore in cui il nuovo stato interno è funzione degli ingressi e dello stato interno corrente, mentre l'uscita è solo funzione dello stato interno corrente

Per implementare gli automi utilizzeremo due metodi:

1. Daremo una definizione *strutturale*, in cui modelliamo il registro di stato, la rete *omega* per il calcolo delle uscite e la rete *sigma* per il calcolo del next state

2. Daremo una definizione *behavioural* che rappresenta lo stato interno come `reg`, usa il blocco `always` per il calcolo del nuovo stato e usa il comando `assign` per il calcolo delle uscite.

## Codici modello strutturale

### Rete Omega

```verilog
module Omega(output [N-1:0] z,
	     input 	    aluctl,
	     input [N-1:0]  A,
	     input [N-1:0]  B);

   parameter N = 32;
   
   assign
     z = (aluctl == 0 ? A+B : A-B);
      
endmodule
```
### Rete Sigma

```verilog
module Sigma(output [N-1:0] newA,
	     output [N-1:0] newB,
	     input 	    wea, web, mux1, mux2, aluctl,
	     input [N-1:0]  X,
 	     input [N-1:0]  Y,
	     input [N-1:0]  A,
	     input [N-1:0]  B);

   parameter N = 32;
   
   assign
     newA = (wea == 0 ? A :
	     (mux1 == 0 ? X :
	      (aluctl == 0 ? A+B : A-B)));

   assign
     newB = (web == 0 ? B :
	     (mux2 == 0 ? Y :
	      (aluctl == 0 ? A+B : A-B)));
   
endmodule
```

### Registro

```verilog
// registro da N bit
// enable e’ il controllo di scrittura
// i0 e’ il segnale in ingresso
// clk e’ il clock
//
// semantica standard: scrive i0 se clk alto e beta, uscita sempre uguale
// al contenuto del registro
//
module registro(r,clk,beta,i0);

parameter N = 32; // registro da 32 bit, per default
output [N-1:0]r; // uscita del registro
input clk; // segnale di clock
input enable; // abilitazione alla scrittura
input [N-1:0]i0; // valore da scrivere
reg [N-1:0]registroN; // valore del registro
initial // inizializzazione del registro a 0
    begin
        registroN = 0;
    end
always @ (posedge clk) // aggiornamento quando il clock va alto
    begin
        if(enable==1) // solo se il segnale di enable e’ a 1
            registroN = i0;
    end
assign
    r = registroN; // uscita sempre uguale al contenuto del registro
endmodule

```

### Test rete

```verilog

module test (output z, input x, input clock)

    wire statocorrente;
    wire nuovostato;

    registro #(1) stato(statocorrente, clock, 1'b1, nuovostato); // tutto da 1 bit
    sigma sigma(nuovostato, x, statocorrente);
    omega omega(z, x, statocorrente);
```

## Codici modello behavioural

Work in progress