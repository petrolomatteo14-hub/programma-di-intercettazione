# Programma di Intercettazione Navale ed Aerea

Un'applicazione MATLAB avanzata per il calcolo del punto e del tempo di intercettazione di navi ed elicotteri in base a coordinate geografiche, velocità e rotte. Sistema completo per operazioni SAR (Search and Rescue), controllo marittimo e pianificazione di missioni navali e aeree.

## Descrizione

Questo programma fornisce una GUI (Graphical User Interface) intuitiva e professionale per calcolare scenari di intercettazione navale e aerea. È uno strumento completo per operazioni di:
- **Soccorso marittimo e aereo (SAR - Search and Rescue)**
- **Controllo e sorveglianza marittima**
- **Pianificazione di operazioni navali e aeree**
- **Evacuazioni mediche urgenti**
- **Intercettazioni rapide**

### Funzionalità Principali

- **Selezione Mezzo**: Scelta tra Nave o Elicottero con preset dedicati per ciascun tipo di mezzo

- **Calcolo dell'intercettazione**: Determina il punto d'incontro tra intercettore e target basandosi su:
  - Coordinate geografiche (latitudine/longitudine) dell'intercettore
  - Coordinate geografiche del mezzo da intercettare
  - Velocità dell'intercettore (in nodi)
  - Velocità del target (in nodi)
  - Rotta/Prua del target (in gradi, 0°=Nord)
  - **Rotta ottimale da seguire**: Il programma calcola automaticamente la rotta che l'intercettore deve seguire
  - **E.T.A. (Estimated Time of Arrival)**: Tempo stimato di arrivo nel formato ore e minuti

- **Scenari Presettati**: Include preset realistici divisi per tipo di mezzo:
  
  **Preset Nave** (4 scenari):
  - Rotta intercettazione nave in avaria
  - Intercettazione nave per pilotaggio Stretto di Messina
  - Intercettazione oceano indiano
  - Soccorso nel golfo del messico
  
  **Preset Elicottero** (4 scenari):
  - Soccorso rapido Mediterraneo
  - Evacuazione medica urgente
  - Ricerca SAR Tirreno
  - Intercettazione veloce Adriatico

- **Basi SAR Preconfigurare**: Database di **58 basi** di soccorso marittime e aeree mondiali con coordinate precise (incluse 8 basi SAR italiane)

- **Visualizzazione Geografica Interattiva**: 
  - Mappa mondiale completa con coastlines
  - Meridiani e paralleli per riferimento geografico
  - **Zoom animato automatico** verso l'area di intercettazione con easing fluido e professionale
  - Pan e zoom manuale per esplorare la mappa
  - Posizioni delle basi SAR
  - Traiettorie vettoriali:
    - **Intercettore**: cerchio viola con freccia magenta
    - **Target**: cerchio verde con freccia verde
    - **Punto di intercettazione**: X blu
  - **Legenda completa** nel pannello dati

- **Pannello Dati Dettagliato**:
  - Visualizzazione del mezzo selezionato (Nave/Elicottero)
  - Dati completi dell'intercettore (coordinate, velocità, rotta, E.T.A.)
  - Dati del target (coordinate, velocità, prua)
  - Punto di intercettazione calcolato
  - **Pulsante "Modifica Dati"** per ricominciare con nuovi valori conservando i dati precedenti

## Utilizzo

### Avvio del Programma

```matlab
mappa_globale
```

All'avvio si presenta una finestra con:
- Due pannelli di input (Intercettore e Nave da Intercettare)
- Dropdown per la selezione del mezzo (Nave o Elicottero)
- Opzioni per utilizzare preset pre-configurati
- Pulsante "Calcola intercettazione"

### Input Manuale

1. **Seleziona il tipo di mezzo**:
   - Nel dropdown in alto a destra, scegli tra "Nave" o "Elicottero"
   - I preset si aggiorneranno automaticamente in base alla selezione

2. Inserisci i dati dell'**Intercettore**:
   - **Latitudine**: formato "38.17 N" o "-33.92 S" (oppure solo il numero decimale)
   - **Longitudine**: formato "15.65 E" o "-74.00 W" (oppure solo il numero decimale)
   - **Velocità**: in nodi (kts) - tipicamente 20-25 kts per navi, 120-180 kts per elicotteri

3. Inserisci i dati del **Target da Intercettare**:
   - **Latitudine**: coordinate iniziali del target
   - **Longitudine**: coordinate iniziali del target
   - **Velocità**: velocità del target (in nodi) - può essere 0 per target stazionario
   - **Prua**: direzione di marcia in gradi (0°=Nord, 90°=Est, 180°=Sud, 270°=Ovest)

4. Clicca su **"Calcola intercettazione"** per ottenere:
   - **Punto di intercettazione** (latitudine/longitudine)
   - **Rotta da seguire** per l'intercettore (in gradi)
   - **E.T.A. (Estimated Time of Arrival)** nel formato "Xh XXm" (ore e minuti)
   - **Visualizzazione grafica** sulla mappa mondiale con zoom automatico sull'area di interesse
   - **Frecce vettoriali** che mostrano le traiettorie convergenti

### Utilizzo dei Preset

1. Spunta la casella **"Usa preset"**
2. I controlli preset si attiveranno
3. Seleziona uno scenario dal menu a tendina (i preset cambiano automaticamente in base al mezzo selezionato)
4. Clicca **"Carica preset"** per popolare automaticamente tutti i campi
5. (Opzionale) Modifica i valori se necessario
6. Clicca **"Calcola intercettazione"**

### Modificare i Dati dopo il Calcolo

Dopo aver visualizzato i risultati:
1. Clicca sul pulsante **"Modifica Dati"** nel pannello dati a destra
2. La GUI tornerà alla schermata di input con tutti i valori precedentemente inseriti
3. Modifica i parametri desiderati
4. Ricalcola l'intercettazione

### Interazione con la Mappa

- **Pan**: Trascina la mappa con il mouse per spostarti
- **Zoom**: Usa la rotellina del mouse o gli strumenti di zoom per ingrandire/ridurre
- **Zoom automatico**: All'avvio del calcolo, la mappa esegue uno zoom animato fluido verso l'area di intercettazione

## Formato delle Coordinate

Il programma è molto flessibile e accetta varie formattazioni per le coordinate:

- **Decimali semplici**: `38.17`, `-33.92`
- **Con emisfero**: `38.17 N`, `15.65 E`, `33.92 S`, `74.00 W`
- **Con simbolo di grado**: `38.17°`, `15.65°`
- **Numeri con virgola**: `38,17` (convertiti automaticamente in punto decimale)

### Convenzioni
- **Latitudine**: positiva a Nord dell'Equatore, negativa a Sud (range: -90° a +90°)
- **Longitudine**: positiva a Est di Greenwich, negativa a Ovest (range: -180° a +180°)
- **Prua/Rotta**: misurata in gradi in senso orario da Nord (0°=Nord, 90°=Est, 180°=Sud, 270°=Ovest)

## Algoritmo di Calcolo

Il programma utilizza un modello cinematico 2D avanzato per risolvere il problema dell'intercettazione:

### Passaggi Principali

1. **Conversione coordinate geografiche → cartesiane**: 
   - Trasforma coordinate geografiche (lat/lon) in coordinate cartesiane locali
   - Utilizza proiezione locale con approssimazione sferica della Terra
   - Raggio terrestre: 6371 km

2. **Calcolo vettori velocità**: 
   - Converte velocità da nodi a km/h (moltiplicazione per 1.852)
   - Scompone la velocità del target nelle componenti x e y basate sulla prua
   - Formula: `v_x = vel * sin(prua)`, `v_y = vel * cos(prua)`

3. **Risoluzione dell'equazione di intercettazione**: 
   - Risolve l'equazione quadratica per trovare il tempo di intercettazione minimo
   - L'equazione deriva dalla condizione: posizione intercettore(t) = posizione target(t)
   - Formula quadratica: `A*t² + B*t + C = 0`
   - Seleziona la soluzione temporale positiva minima

4. **Calcolo punto di intercettazione**: 
   - Proietta la posizione del target al tempo t calcolato
   - Riconverte da coordinate cartesiane a geografiche

5. **Calcolo rotta (azimuth)**:
   - Utilizza la formula dell'azimuth geodetico (bearing)
   - Calcolo basato su trigonometria sferica senza necessità di Mapping Toolbox

### Formule Chiave

```matlab
% Conversione velocità
vel_kmh = vel_nodi * 1.852

% Conversione lat/lon → x,y (approssimazione locale)
x = (lon - lon_0) * cos((lat + lat_0)/2) * π/180 * R
y = (lat - lat_0) * π/180 * R

% Equazione di intercettazione
A = v_target_x² + v_target_y² - v_intercettore²
B = 2*(Δx*v_target_x + Δy*v_target_y)
C = Δx² + Δy²

% Tempo di intercettazione
t = (-B ± sqrt(B² - 4AC)) / (2A)  [prendi il minimo t > 0]

% Azimuth (bearing)
bearing = atan2(sin(Δlon)*cos(lat2), cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(Δlon))
```

### Casi Speciali Gestiti

- **Target stazionario** (velocità = 0): Calcolo semplificato della rotta diretta
- **Velocità uguali**: Risoluzione dell'equazione lineare degenerata
- **Intercettazione impossibile**: Gestione del caso in cui il target è troppo veloce o distante
- **Discriminante negativo**: Nessuna intercettazione possibile (viene mostrato messaggio)

### Validazioni

- Controllo che tutti i campi numerici siano validi
- Verifica che il mezzo sia stato selezionato
- Gestione errori con messaggi informativi
- Controllo di validità degli oggetti UI (handle graphics)

## Requisiti

### Software
- **MATLAB R2016b o successive** (testato su R2020a+)
- **Toolbox richiesti**: Nessuno (il programma usa solo funzioni MATLAB base)
- **Optional**: File `coastlines.mat` per la visualizzazione delle coste mondiali
  - Se non disponibile, la mappa mostrerà solo gli elementi essenziali (meridiani, paralleli, basi SAR)

### Hardware
- **RAM consigliata**: 4 GB minimo, 8 GB raccomandato per prestazioni ottimali
- **Display**: Risoluzione minima 1400x800 pixel (dimensione finestra del programma)
- **Processore**: Qualsiasi processore compatibile con MATLAB

### File Necessari
- `intercetto.m` - Script principale contenente tutte le funzioni
- `coastlines.mat` - (opzionale) Database delle coste mondiali

## Struttura del Progetto

```
programma-di-intercettazione/
│
├── intercetto.m          # Script principale (688 righe)
│   ├── Funzione principale: mappa_globale
│   ├── Funzioni annidate:
│   │   ├── calcola_intercettazione()
│   │   ├── parse_coordinate()
│   │   ├── parse_number()
│   │   ├── calculate_azimuth()
│   │   ├── update_preset_list()
│   │   ├── toggle_preset_controls()
│   │   ├── apply_preset()
│   │   └── modifica_dati_callback()
│   └── Callback esterni:
│       └── sar_click_callback()
│
├── coastlines.mat        # (opzionale) Database coste mondiali
│
└── README.md            # Documentazione completa
```

### Componenti Principali del Codice

- **Lines 1-40**: Inizializzazione GUI e controlli di input
- **Lines 45-68**: Definizione preset (navi ed elicotteri)
- **Lines 90-105**: Database basi SAR (58 basi mondiali)
- **Lines 145-300**: Funzione calcolo intercettazione
- **Lines 318-477**: Creazione pannello risultati e mappa con zoom animato
- **Lines 490-550**: Funzioni di parsing e calcolo azimuth
- **Lines 553-650**: Funzioni gestione preset e UI
- **Lines 578-682**: Callback per modifica dati (ripristino interfaccia)

## Preset Dettagliati

### Preset Nave

#### 1. Rotta Intercettazione Nave in Avaria
- **Scenario**: Soccorso urgente a nave in difficoltà vicino le coste siciliane
- **Intercettore**: 36.70°N, 14.82°E, velocità 25 kts
- **Target**: 36.42°N, 14.71°E, velocità 4 kts (ridotta per avaria), prua 135°
- **Contesto**: Operazione SAR nel Canale di Sicilia

#### 2. Intercettazione Nave per Pilotaggio Stretto di Messina
- **Scenario**: Intercettazione per servizio di pilotaggio nello Stretto di Messina
- **Intercettore**: 38.17°N, 15.65°E, velocità 20 kts
- **Target**: 37.86°N, 15.55°E, velocità 12 kts, prua 10°
- **Contesto**: Servizio di pilotaggio obbligatorio per navigazione nello Stretto

#### 3. Intercettazione Oceano Indiano
- **Scenario**: Operazione di intercettazione in acque internazionali
- **Intercettore**: 31.99°S, 115.57°E, velocità 22 kts
- **Target**: 42.45°S, 78.34°E, velocità 12 kts, prua 30°
- **Contesto**: Operazione di controllo marittimo offshore Australia

#### 4. Soccorso nel Golfo del Messico
- **Scenario**: Operazione SAR nel Golfo del Messico
- **Intercettore**: 29.48°N, 94.26°W, velocità 20 kts
- **Target**: 24.82°N, 91.85°W, velocità 8 kts, prua 260°
- **Contesto**: Soccorso a nave in difficoltà in acque internazionali

### Preset Elicottero

#### 1. Soccorso Rapido Mediterraneo
- **Scenario**: Intervento rapido SAR nelle acque siciliane
- **Intercettore**: 38.00°N, 12.56°E, velocità 120 kts
- **Target**: 38.27°N, 11.79°E, velocità 15 kts, prua 340°
- **Contesto**: Elicottero da Trapani verso nave in difficoltà

#### 2. Evacuazione Medica Urgente
- **Scenario**: Evacuation medicale (MEDEVAC) urgente
- **Intercettore**: 37.49°N, 15.07°E, velocità 150 kts
- **Target**: 38.50°N, 14.29°E, velocità 0 kts (stazionaria), prua 0°
- **Contesto**: Elicottero da Catania verso nave ferma per emergenza medica

#### 3. Ricerca SAR Tirreno
- **Scenario**: Operazione di ricerca nel Mar Tirreno
- **Intercettore**: 41.86°N, 12.43°E, velocità 130 kts
- **Target**: 42.55°N, 10.44°E, velocità 3.5 kts (pesca), prua 180°
- **Contesto**: Elicottero da Pratica di Mare verso peschereccio disperso

#### 4. Intercettazione Veloce Adriatico
- **Scenario**: Intercettazione rapida di imbarcazione sospetta
- **Intercettore**: 41.14°N, 16.88°E, velocità 180 kts
- **Target**: 39.96°N, 19.03°E, velocità 30 kts (veloce), prua 60°
- **Contesto**: Elicottero da Brindisi verso motoscafo in fuga

## Basi SAR Mondiali (58 totali)

Il programma include un database completo di 58 basi SAR globali:

### Basi SAR Italiane (8)
- **Catania** - 37.4667°N, 15.0647°E
- **Trapani** - 37.9114°N, 12.4880°E  
- **Decimomannu** - 39.3542°N, 8.9725°E
- **Grottaglie** - 40.5169°N, 17.4031°E
- **Pratica di Mare** - 41.6544°N, 12.4456°E
- **Lamezia Terme** - 38.9053°N, 16.2422°E
- **Brindisi** - 40.6328°N, 17.9467°E
- **Venezia** - 45.5056°N, 12.3517°E

### Basi SAR Internazionali (50)
Include basi in: Nord America, Sud America, Europa, Africa, Asia, Oceania
- Esempi: Miami, Halifax, Reykjavik, Lisbon, Cape Town, Perth, Tokyo, Singapore, Dubai, Sydney, ecc.


## Note Importanti e Limitazioni

### Validità del Modello
- Le velocità devono essere **positive** (≥ 0)
- Le coordinate utilizzano il **formato standard internazionale**:
  - Latitudine: da -90° (Polo Sud) a +90° (Polo Nord)
  - Longitudine: da -180° (Ovest) a +180° (Est)
- L'algoritmo utilizza **approssimazioni locali** valide su distanze fino a **500-1000 km**
- Per distanze superiori, considerare effetti della curvatura terrestre e proiezioni più accurate

### Fattori Non Considerati
Per operazioni reali, considerare anche:
- **Correnti marine**: possono influenzare significativamente la traiettoria
- **Venti**: effetto importante soprattutto per elicotteri
- **Condizioni meteo**: visibilità, onde, tempeste
- **Cambiamenti di rotta dinamici**: il target potrebbe modificare direzione
- **Consumo carburante**: autonomia dell'intercettore
- **Altitudine** (per elicotteri): influenza su velocità e consumo
- **Ostacoli geografici**: isole, secche, zone di interdizione

### Precisione
- **Coordinate**: precisione fino a 4 decimali (circa 10 metri)
- **Tempo**: arrotondato ai minuti
- **Velocità**: input in nodi, calcolo interno in km/h
- **Rotta**: precisione a 0.1°

### Uso Consigliato
- ✅ **Pianificazione preliminare** di operazioni SAR
- ✅ **Addestramento** e simulazioni didattiche
- ✅ **Calcoli rapidi** in situazioni tattiche
- ✅ **Valutazione fattibilità** di intercettazione
- ⚠️ **Non sostituisce** sistemi di navigazione professionali
- ⚠️ **Verificare sempre** con strumenti nautici/aerei certificati

## Scenari di Utilizzo

### Operazioni Militari e di Sicurezza
- **Controllo marittimo**: Intercettazione di navi sospette in acque internazionali
- **Intercettazione veloce**: Inseguimento di imbarcazioni che violano zone protette
- **Esercitazioni tattiche**: Simulazione di scenari navali e aerei
- **Pianificazione operativa**: Pre-calcolo di missioni e valutazione fattibilità

### Operazioni SAR (Search and Rescue)
- **Soccorso urgente**: Calcolo rapido dei punti d'incontro per salvataggi
- **Evacuazione medica (MEDEVAC)**: Coordinamento elicotteri per emergenze mediche a bordo
- **Ricerca dispersi**: Pianificazione sweep pattern e intercettazione di derive
- **Coordinamento multi-asset**: Ottimizzazione di rotte per più mezzi di soccorso

### Servizi Marittimi
- **Pilotaggio portuale**: Calcolo punto di incontro per servizi di pilotaggio (es. Stretto di Messina)
- **Rimorchio**: Pianificazione di operazioni di traino di navi in avaria
- **Trasferimenti**: Coordinamento di trasferimenti personale tra navi
- **Rifornimenti in mare**: Calcolo rendezvous per rifornimenti

### Didattica e Formazione
- **Insegnamento navigazione**: Visualizzazione pratica di concetti di cinematica navale
- **Geometria nautica**: Dimostrazione di calcoli di rotta e intercettazione
- **Corsi SAR**: Addestramento per operatori di soccorso marittimo
- **Simulazioni**: Esercitazioni senza rischi per studenti di accademie navali

### Ricerca e Sviluppo
- **Test algoritmi**: Validazione di algoritmi di intercettazione
- **Analisi scenari**: Studio di situazioni tattiche complesse
- **Ottimizzazione rotte**: Ricerca di soluzioni ottimali per problemi di intercettazione

---

## Autore
Matteo Petrolo 

