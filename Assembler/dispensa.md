--- 
author: 
  - "Leonardo Scoppitto"
classoption: a4paper
date: "November 2020"
documentclass: article
fontsize: 12pt
geometry: "left=3.5cm,right=3cm,top=3cm,bottom=3cm"
output: pdf_document
title: Assembler
---

# Introduzione

Il linguaggio assembly è la forma leggibile dall'uomo del linguaggio nativo del calcolatore e ogn istruzione specifica sia l'operazione da svolgere che gli operandi coinvolti.

# Registri

Vediamo le principali operazioni aritmetiche:

```Assembly
ADD dest, src, src
SUB dest, src, src
MUL dest, src, src
```
Il primo operando viene chiamato **mnemonico** e indica l'operazione da fare, mentre gli altri elementi sono i registri con cui si opera.\
I registri si indicano con la lettera `Rx`, seguiti dal numero `x` che li identifica. Alcuni operandi vengono chiamati **costanti** o **immediati** perché sono direttamente utilizzabili senza dover accedere in memoria o ai registri, vengono indicati con il simbolo `#` (es. `#1` è la costante 1) e sono *unsigned* a 8 o 12 bit, i quali possono essere espressi in decimale o in esadecimale con il prefisso `0x`.\
I registri, solitamente sono 16 e sono così distribuiti:

* `R0` può essere una variabile temporanea, un parametro o il **valore da restituire**

* `R1-R3` possono essere parametri o variabili temporanee

* `R4-R11` sono utilizzati per le variabili salvate

* `R12` può essere usato per una variabile temporanea

* `R13` è lo *stack pointer* (SP)

* `R14` è il *link register* (LR)

* `R15` è il *program counter* (PC)

Per copiare un registro o un parametro in un altro si usa l'istruzione `MOV Rdest, Rsrc`

# Memoria

La memoria non è altro che un grosso vettore di parole che contiene i dati del programma, i quali prima di essere elaborati devono essere caricati nei registri. Nell'architettura ARM a 32-bit, ovviamente la memoria è a 32 bit ed è *byte addressable*. Ogni parola di 32 bit è costituita da 4 byte di 8 bit ciascuno, il cui byte più significativo è quello di sinistra.\
Per caricare un indirizzo in memoria si usa l'istruzione `LDR`, specificando l'indirizzo base e uno spiazzamento (offset), ricordandosi che ogni parola è di 4 byte, quindi la parola all'indice 1 è all'indirizzo 4, quella di indice 2 è all'indirizzo 8 e così via: *indirizzo = 4 volte l'indice*.
```Assembly
LDR R7, [R5, #8] @ R7 è il dato contenuto nell'indirizzo (R5+8)
```
Se voglio fare l'operazione inversa uso l'istruzione `STR` con la stessa formatazione della load.

# Istruzioni logiche e operazioni sui bit

Le principali instruzioni logiche sono `AND`, `ORR`, `EOR` (xor) e `BIC` (bit clear) e se eseguite operano bit a bit scrivendo il risultato sul registro di destinazione (la prima sorgente è sempre un registro, mentre la seconda può essere qualsiasi cosa).\
L'istruzione `MVN` esegue la negazione bit a bit dell'unica sorgente e la scrive nella destinazione.\
L'istruzione `BIC` serve per maschertare i bit che non ci interessano:
```Assembly
@ R1 = 0100 0110 1010 0001 1111 0001 1011 0111 (0x46A1F1B7)
@ R2 = 1111 1111 1111 1111 0000 0000 0000 0000 (0xFFFF0000)
BIC R6, R1, R2
```
Azzera i bit che sono a 1 di `R2` e in questo caso i due byte più signidicativi di `R1` sono mascherati, mentre quelli non mascherati sono scritti in `R6`.\
Ci sono poi le istruzioni di traslazione:

* Per gli Shift logici abbiamo `LSL` e `LSR`.

* Per gli Shift Aritmetici abbiamo `ASR` (a sinistra lo shift logico e aritmetico coincidono).

* Per la rotazione abbiamo `ROR` (per ruotare a sinistra si esegue una rotazione a destra numero di passi complementare a quelli che si vogliono fare). Le rotazioni sono come gli shift, solo che quello che trabocca, ricompare dall'altra parte, tipo Pacman.

## Flag di condizione

I flag possono essere:

* **N:** *negative*

* **Z:** *zero*

* **C:** *carry*

* **V:** *overflow*

Questi flag vengono impostati dall'ALU sui primi 4 bit più significativi del CPRS (*Current Program Status Register*) tramite l'istruzione `CMP`, ovvero *compare*, che opera una sottrazione fra il primo e il secondo registro, deducendo dal risultato la natura dei due numeri. Ad esempio, se due numeri sono uguali, **Z** è 1 e questa condizione viene verificata anche quando si compiono operazioni come la `ADDEQ`, che esegue l'addizione solo se il flag *Z* è *true*.

# Salti

I salti sevono per i cicli *while*, per i blocchi condizionali *if-then-else* e per gli *switch case*. Normalmente, infatti, il program counter si incrementa di 4 alla fine di ogni istruzione, così da puntare alla successiva. però per eseguire tutti i costrutti visti sopra, questo non è possibile.\
Esistono quindi due tipi di salti per dire al program counter di non seguire la sua logica di base, ovvero il salto semplice `B` e il salto con collegamente (*Branch and link*) `BL`. Entrambi i tipi di salto, poi, possono essere sia incondizionati che condizionati con un mnemonico.\ 
Un esempio:
```Assembly
      MOV R0, #4 ; R0 = 4
      ADD R1, R0, R0 ; R1 = R0 + R0 = 8
      CMP R0, R1 ; sistema flag per R0−R1 = −4. NZCV = 1000
      BEQ DEST ; non salta (Z != 1)
      ORR R1, R1, #1 ; R1 = R1 OR 1 = 9
DEST: ADD R1, R1, #78 ; R1 = R1 + 78 = 87
```

Il costrutto *if/else* si implementa con una `CMP` seguita da un'operazione con mnemonico, mentre il costrutto *while* con una cosa di questo genere:

```Assembly
        R0 = potenza, R1 = x
        MOV R0, #1 ; potenza = 1
        MOV R1, #0 ; x = 0
WHILE: CMP R0, #128 ; potenza != 128 ?
        BEQ FINE ; se potenza == 128, esce dal ciclo
        LSL R0, R0, #1 ; potenza = potenza * 2
        ADD R1, R1, #1 ; x = x + 1
        B WHILE ; ripete il ciclo WHILE
FINE
```
Il ciclo for è come il *while*, ma con una variabile di controllo.

# Chiamate ai sottoprogrammi

Come negli altri linguaggi di programmazione è possibile implementare delle sotto-routine per rendere il codice modulare. Per convenzione i parametri in numero inferiore o uguale a 4, vengono messi nei registri `R0-R3` prima di effettuare la chiamata.
