# STOP WATCH – JACOPO OLIVO
## DESCRIZIONE

**Stop Watch** è un semplice cronometro sviluppato in Flutter, con funzioni di **start, stop, reset, pause** e **resume**.

L’**interfaccia** mostra:
- Il tempo formattato in minuti e secondi,
- Lo stato attuale del cronometro (debug),
- Una barra di avanzamento che rappresenta un ciclo di 60 secondi,
- Due pulsanti floating per controllare il cronometro.

## FUNZIONAMENTO
Il cronometro utilizza due stream principali:
- **_tickController** → genera un tick ogni *100ms*
- **_secondController** → incrementa i secondi totali ogni *10 tick*

**Funzionalità disponibili**:
- *START* → avvia il conteggio
- *STOP* → ferma momentaneamente
- *RESET* → riporta il tempo a 00:00
- *PAUSE* → mette in pausa il cronometro
- *RESUME* → riprende il cronometro

Durante il conteggio, una *barra progressiva** indica l’avanzamento all’interno del minuto corrente (0 → 60 secondi).

## STRUTTURA DEL CODICE
Il progetto si basa su due classi principali:

**MyStopWatch**
Estende *StatelessWidget* e gestisce:
- Titolo,
- Avvio della pagina iniziale **MyHomePage**.

**MyHomePage**
Estende StatefulWidget e contiene la logica del cronometro.

Metodi principali:
- **_startStreams** → avvia i timer e converte i *tick* in secondi.
- **_changeState** → gestisce il ciclo dei tre stati: START → STOP → RESET.
- **_pauseResume** → mette in pausa o riprende il cronometro.
- **_convertCounter** → converte i secondi nel formato *minuti:secondi*.
- **build** → costruisce l’interfaccia grafica (testo, barra, pulsanti).

Gli stream vengono *chiusi* correttamente nel metodo **dispose** per evitare problemi di memoria.

## REQUISITI DELL’APP
Per eseguire il progetto servono:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installato (cliccarlo per essere reindirizzati al sito per l'installazione),
- Dart SDK (incluso in Flutter),
- Un editor come **Android Studio** o **Visual Studio Code**,
- Un emulatore o dispositivo fisico per il test.

## ALL'AVVIO 
Dopo aver clonato o copiato il progetto:
```bash
flutter pub get
flutter run
```
## AUTORE —

Sviluppo del progetto a cura di **Jacopo Olivo**,
**5IB ITIS C. Zuccante – TPSIT ** 2025/26
