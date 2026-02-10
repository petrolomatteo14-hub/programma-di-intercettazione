# Programma di Intercettazione Navale

Un'applicazione MATLAB per il calcolo del punto e del tempo di intercettazione di navi in base a coordinate geografiche, velocità e rotte.

## Descrizione

Questo programma fornisce una GUI intuitiva per calcolare scenari di intercettazione navale. È utile per operazioni di soccorso (SAR - Search and Rescue), controllo marittimo e pianificazione di operazioni navali.

### Funzionalità Principali

- **Calcolo dell'intercettazione**: Determina il punto d'incontro tra due navi basandosi su:
  - Coordinate geografiche (latitudine/longitudine) dell'intercettore
  - Coordinate geografiche della nave da intercettare
  - Velocità dell'intercettore (in nodi)
  - Velocità della nave target (in nodi)
  - Rotta/Prua della nave target (in gradi)

- **Scenari Presettati**: Include 5 scenari pre-configurati reali:
  - Soccorso a nave in avaria vicino le coste italiane
  - Intercettazione per pilotaggio nello Stretto di Messina
  - Intercettazione nell'Oceano Indiano
  - Operazione di soccorso nel Golfo del Messico
  - Intercettazione nell'Oceano Atlantico

- **Basi SAR Preconfigurare**: Database di 50+ basi di soccorso marittime mondiali con coordinate precise

- **Visualizzazione Geografica**: Mappa interattiva con:
  - Coste mondiali (se disponibili)
  - Posizioni delle basi SAR
  - Traiettorie delle navi calcolate
  - Punto di intercettazione

## Utilizzo

### Avvio del Programma

```matlab
mappa_globale
```

### Input Manuale

1. Inserisci i dati dell'**Intercettore**:
   - **Latitudine**: formato "36.70 N" o "-33.92 S" (oppure solo il numero)
   - **Longitudine**: formato "14.82 E" o "-74.00 W" (oppure solo il numero)
   - **Velocità**: in nodi (kts)

2. Inserisci i dati della **Nave da Intercettare**:
   - **Latitudine**: coordinate iniziali della nave target
   - **Longitudine**: coordinate iniziali della nave target
   - **Velocità**: velocità della nave (in nodi)
   - **Prua**: direzione di marcia in gradi (0°=Nord, 90°=Est, 180°=Sud, 270°=Ovest)

3. Clicca su **"Calcola intercettazione"** per ottenere:
   - Punto di intercettazione (lat/lon)
   - Tempo stimato di intercettazione (ore:minuti:secondi)
   - Distanza da percorrere
   - Rotta da seguire per l'intercettore

### Utilizzo dei Preset

1. Spunta la casella **"Usa preset"**
2. Seleziona uno scenario dal menu a tendina
3. Clicca **"Carica preset"** per popolare automaticamente i campi
4. Modifica i valori se necessario e ricalcola

## Formato delle Coordinate

Il programma accetta le seguenti formazioni:

- Decimali: `36.70`, `-33.92`
- Con emisfero: `36.70 N`, `14.82 E`, `33.92 S`, `74.00 W`
- Con simbolo: `36.70°`, `14.82°`
- Numeri con virgola: `36,70` (convertiti automaticamente a punto)

## Algoritmo

Il programma utilizza un modello cinematico 2D per risolvere il problema dell'intercettazione:

1. **Conversione coordinate**: Trasforma coordinate geografiche (lat/lon) in coordinate cartesiane locali
2. **Vettori velocità**: Calcola i vettori velocità basati su velocità e prua
3. **Risoluzione matematica**: Risolve l'equazione quadratica per trovare il tempo di intercettazione
4. **Riconversione**: Trasforma il punto di intercettazione da coordinate cartesiane a georafiche

### Formule Chiave

- Conversione velocità: nodi → km/h (moltiplicazione per 1.852)
- Proiezione Mercatore locale per coordinate cartesiane
- Equazione parametrica: `|P_intercettore(t) - P_nave(t)| = 0`

## Requisiti

- MATLAB R2016b o successive
- Toolbox: MATLAB disponibile di default
- Optional: `load('coastlines')` per la visualizzazione delle coste (Geography/Mapping Toolbox)

## Struttura del File

```
mappa_globale.m  - Script principale
README.md        - Questo file
```

## Autore

Progetto informatica2

## Note Importanti

- Le velocità devono essere positive
- Le coordinate utilizzano il formato standard internazionale (latitudine da -90 a +90, longitudine da -180 a +180)
- L'algoritmo utilizza approssimazioni locali valide su distanze fino a 500-1000 km
- Per operazioni reali, considerare variabili come correnti marine, venti e cambiamenti di rotta dinamici

## Scenari di Utilizzo

- **Operazioni SAR**: Calcolo rapido dei punti d'incontro
- **Controllo marittimo**: Interception di navi sospette
- **Esercitazioni tattiche**: Simulazione di scenari navali
- **Pianificazione**: Pre-calcolo di operazioni marittime
- **Didattica**: Insegnamento della navigazione e della geometria navale
