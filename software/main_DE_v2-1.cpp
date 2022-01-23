/*
    DMX Controller v2.1
    Copyright (C) 2022 S.Pauthner

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <Arduino.h>
#include <LiquidCrystal_I2C.h>
#include <RotaryEncoder.h>
#include <DmxSimple.h>
#include <EEPROM.h>

/* ---  DMX-Controller V2.1 ---
  Programmcode zur Steuerung von DMX Geräten
  für Hardware Version: 1.0
  Software Version:     2.1 beta
  Autor:                S. Pauthner
  Änderungsdatum:       23.01.2022

  Bibliotheken:         LiquidCrystal_I2C, RotaryEncoder, DmxSimple (! Enthält eigene Modifizierungen), EEPROM, Arduino
  Lizenz:               GNU GPLv3

  Features:           - manuelle Steuerung von 72 DMX Kanälen
                      - 3 Chaser mit 20 Scenen der ersten 8 Kanäle
                      - Anpasung der Chaserparameter mit Fadern
                      - einstellbarer Startmodus
                      - insgesamt 60 speicher und abrufbare Scenen á 8 Kanäle in 3 Chasern

  Bugfixes:
                      - FadeTime Anzeige korrigiert
                      - Chaserstart optimiert
                      - LCD update Zeit optimiert

  Default-verkabelung:
    PC6/Reset   --> Taster zu GND
    PD0/RXD     --> Serial Interface
    PD1/TXD     --> Serial Interface
    PD2/D2      --> MAX 485 CPA
    PD3/D3      --> N.C.
    PD4/D4      --> N.C.
    PB6/XTAL1   --> Oszillator 16MHz
    PB7/XTAL2   --> Oszillator 16MHz
    PD5/D5      --> N.C.
    PD6/D6      --> Drehencoder SW
    PD7/D7      --> Drehencoder CLK
    PB0/D8      --> Drehencoder DT

    PB1/D9      --> N.C.
    PB2/D10     --> N.C.
    PB3/D11     --> N.C.
    PB4/D12     --> N.C.
    PB5/D13     --> LED
    PC0/A0      --> Fader 1
    PC1/A1      --> Fader 2
    PC2/A2      --> Fader 3
    PC3/A3      --> Fader 4
    PC4/SCL     --> I²C Display SDA
    PC5/SDA     --> I²C Display SCL
*/

#define PIN_IN1 7   // Drehencoder CLK
#define PIN_IN2 8   // Drehencoder DT
#define PIN_BTN 6   // Drehencoder SW

#define Fader1  0   // Faderbelegung #1
#define Fader2  1   // Faderbelegung #2
#define Fader3  2   // Faderbelegung #3
#define Fader4  3   // Faderbelegung #4
static uint8_t faderInput[4] = {Fader1, Fader2, Fader3, Fader4};

LiquidCrystal_I2C lcd(0x27,16,2);                                               // Objekt lcd erzeugen (I²C Adresse, Spalten, Zeilen)
RotaryEncoder encoder(PIN_IN1, PIN_IN2, RotaryEncoder::LatchMode::TWO03);       // Objekt encoder erzeugen

/* DMX Output */
// DMX Output abrufen mit   DmxSimple.getValue(Channel);    --> Bibliotheksveränderung siehe Anhang "/doc/Recources/README"

/* Chaser Parameter */
unsigned short sceneSpeed = 0;    // die Zeit pro Scene in 100 ms
unsigned short fadeTime = 0;      // die Fadezeit bis zum letztendlichen Wert in 100 ms
unsigned short masterDimmer = 0;  // der Masterdimmer bei Chaseraktivitäten in Prozent (Multiplikator)
unsigned short richtung = 0;      // die Richtung, in der Scenen im Chaser abgerufen werden (Aufsteigend, Absteigend, Hin und Her, Zufall)
static double aktScene[8];        // die aktuelle Chaserscene
static double altScene[8];        // die vorherige Chaserscene
unsigned long timeScene = millis(); // Zeitvariable zur Scenenverwaltung
unsigned long timeFade = millis();// Zeitvariable zur Fadesteuerung
bool nurNull = false;             // Variable zur Überprüfung der Scenenwerte
bool scenedir = true;             // Variable für Hin Her
short fadePosition = 0;           // Variable zum Faden im Chaser (in 255 Schritten)
short lastChaserNr = 0;           // Variable, die die Letzte Scenennummer trägt --> hin her funktion

/* Programmablauf/-steuerung */
static unsigned short lcdUpdateTime = 200; // Anzahl der Millisekunden, bis das LCD geupdatet wird
static uint8_t status[4];         // aktuelle Aufgabe
static uint8_t statusebene = 0;   // Statusebene: 0 = Menu, 1 = Modusauswahl, 2 = Chaserauswahl, 3 = Scenenauswahl
static bool action = false;       // Select Button
static bool printRefresh = true;  // Variable, um das Lcd neu zu Zeichnen
static unsigned long time;        // Variable, die mit millis() gleichgesetzt wird, um ein zu häufiges Updaten des LCDs zu verhindern
static short fader[4];          // Fader Array --> ADC Wert durch 4
static bool faderChange[4] = {true, true, true, true};   // Variable, die bei Änderung der Fader auf true gesetzt wird


// Funktion, um den Drehencoder abzufragen
void trackRE(uint8_t position, uint8_t untergrenze, uint8_t obergrenze, uint8_t modifikator){
  /*
    byte position     : Welcher Index des Arrays/Pointers status/statusPointer modifiziert werden soll
    byte untergrenze  : Wo die Untergrenze der möglichen Werte liegt (Werte zwischen 0 und 255)
    byte obergrenze   : Wo die obergrenze der möglichen Werte liegt (Werte zwischen 0 und 255)
    byte modifikator  : Um wie viel der Wert erhöht bzw. verringert werden soll
  */
  static int pos = 0;
  encoder.tick();
  int newPos = encoder.getPosition();
  if (pos != newPos) {         // RE Aktionen
    // RE nach Links  -  Verringern
    if (pos > newPos+1){       // newPos + 1 um eine grobere erfassung zu bekommen
      if (status[position] <= untergrenze){
        status[position] = obergrenze;
      }
      else{
        status[position] = status[position] - modifikator;
      }
      printRefresh = true;
      pos = newPos;
    }
    // RE nach Rechts  -  Erhöhen
    else if (pos < newPos-1){  // newPos - 1 um eine grobere erfassung zu bekommen
      if (status[position] >= obergrenze){
        status[position] = untergrenze;
      }
      else{
        status[position] = status[position] + modifikator;
      }
      printRefresh = true;
      pos = newPos;
    }

  }
}

// Funktion um einen losgelassenen Selectbutton in eine Variable zu speichern
void buttonPress(){
  /*
    Push RE auslesen
    bei loslassen wird *actionPointer auf true gesetzt
      --> manuelles resetten

    faderChange auf True setzen um werte neu zu laden
  */
  static bool btnPres = false; // Variable zum auslesen des Selectbuttons
  if (digitalRead(PIN_BTN) == false){
    btnPres = true;
  }
  if (digitalRead(PIN_BTN) == true && btnPres == true){
    btnPres = false;
    action = true;
    printRefresh = true;
    for (uint8_t i = 0; i < 4; i++) {
      faderChange[i] = true;
    }
  }

}

// setup Funktion
void setup(){
  lcd.init();                      // LCD initialisieren
  lcd.backlight();
  lcd.begin(16,2);
  lcd.setCursor(1,0);
  lcd.print("DMX-Controller");
  lcd.setCursor(6,1);
  lcd.print("v2.1");

  pinMode(PIN_BTN, INPUT);        // Select Button als Input konfigurieren

  DmxSimple.maxChannel(72);       // DMX universum auf 72 limitieren
  DmxSimple.usePin(2);            // DMX Output Pin: 2
  for (uint8_t i = 1; i <= 72; i++) {
    DmxSimple.write(i, 0);
  }

  for (uint8_t i = 0; i < 4; i++) {    // Anfangsmodus laden
    status[i] = EEPROM.read(600 + i);
  }
  statusebene = EEPROM.read(610);     // Anfangsebene laden

  if (status[0] == 3 || status[0] == 4) {               // Wenn Scene oder Chaser als start, einmal die Szenenaktivität ausführen
    action = true;
  }
  if (status[0] == 4){                                  // bei Chaserstart Scene 1 laden
    for (uint8_t i = 0; i < 8; i++) {
      aktScene[i] = EEPROM.read((status[1]*200 + status[2]*8 + i));
      if (aktScene[i] != 0) {
        nurNull = false;
      }
    }
  }



  delay(700);

}

// loop Funktion

void loop(){

  for (uint8_t i = 0; i < 4; i++) {   // Fader updaten

    if (analogRead(faderInput[i])/4 != fader[i]) {
      fader[i] = analogRead(faderInput[i])/4;
      faderChange[i] = true;
    }

  }

  switch (statusebene) {        // Aktivität nach Statusebene
    case 0: // Menuebene
      trackRE(0, 0, 5, 1);      // Rotary Encoder aktualisieren
      break;
    case 1: // Modusebene/Chaserauswahl
      if (status[0] >= 1 && status[0] <= 4){  // Scene hinzufügen, löschen, abrufen; Chaser Abrufen
        trackRE(1, 0, 3, 1);
      }
      else if (status[0] == 0) {  // Manuell
        trackRE(3, 0, 68, 4);
        for (uint8_t i = 0; i < 4; i++) {
          if (faderChange[i] == true) {
            DmxSimple.write(status[3] + 1 + i, fader[i]);
            faderChange[i] = false;
            printRefresh = true;
          }
        }
      }
      else{ // Einstellungen
          trackRE(1, 0, 3, 1);
      }
      break;

    case 2:
      if (status[0] == 5){  // Einstellungen Chaserauswahl
        trackRE(2, 0, 3, 1);
      }
      else if (status[0] == 4){ // Chaserausführung
        trackRE(2, 0, 19, 1);               // Scrollfunktion durch die Scenen

        for (uint8_t i = 0; i < 4; i++) {   // Manipulationsvariablen anpassen
          if (faderChange[i] == true) {
            switch (i) {
              case 0: // sceneSpeed
                sceneSpeed = (fader[i]*100)/85;
                break;
              case 1: // fadeTime
                fadeTime = (fader[i]*100)/255;
                break;
              case 2: // Dimmer
                masterDimmer = (fader[i]*100)/255;
                for (short i = 0; i < 8; i++) {
                  DmxSimple.write(i + 1 , ((altScene[i] + (((aktScene[i] - altScene[i])/255)*fadePosition))*masterDimmer) / 100 );
                }
                break;
              case 3: // Richtung
                if (fader[i] <= 4){
                  richtung = 0;   // Aufsteigend
                }
                else if (fader[i] <= 38){
                  richtung = 1;   // Absteigend
                }
                else if (fader[i] <= 175){
                  richtung = 2;   // Hin und Her
                }
                else{
                  richtung = 3;   // Zufällig
                }
            }
            faderChange[i] = false;
            printRefresh = true;
          }
        }

        if (millis() - timeScene >= sceneSpeed * 100) { // Eine Scene weiter/ ein Step
          lastChaserNr = status[2];
          for (uint8_t i = 0; i < 8; i++) { // aktuelle Scene in alteScene Speichern
            altScene[i] = aktScene[i];
          }
          nurNull = true;
          int n = 0;
          while(nurNull == true && n < 40){           // aktuelle Scene aus EEPROM lesen und auf NUR NULL prüfen
            n++;
            switch (richtung) {     // Neue Scenennummer erstellen
              case 0: // aufsteigend
                status[2] = status[2] + 1;
                if (status[2] >= 20){
                  status[2] = 0;
                }
                break;
              case 1: // Absteigend
                if (status[2] <= 0) {
                  status[2] = 19;
                }
                else{
                status[2] = status[2] - 1;
                }
                break;
              case 2: // Hin und Her
                if (scenedir == true){    // Aufsteigender Part
                  status[2] = status[2] + 1;
                  if (status[2] >= 19) {
                    scenedir = false;
                  }
                  if (status[2] == lastChaserNr && status[2] <=18) {
                    status[2] = status[2] + 1;
                  }
                }
                else{                     // Sinkender Part
                  status[2] = status[2] - 1;
                  if (status[2] <= 0){
                    scenedir = true;
                  }
                  if (status[2] == lastChaserNr && status[2] >= 1) {
                    status[2] = status[2] - 1;
                  }
                }
                break;
              case 3: // Zufall
                status[2] = random(0, 19);
                break;
              }
              for (uint8_t i = 0; i < 8; i++) {
                aktScene[i] = EEPROM.read((status[1]*200 + status[2]*8 + i));
                if (aktScene[i] != 0) {
                  nurNull = false;
                }
              }
              fadePosition = 0;

          }
          n = 0;
          timeScene = millis();
          printRefresh = true;
        }

        if ((millis() - timeFade >= fadeTime && fadePosition < 256) && fadeTime > 0){ // Faden ermöglichen
          for (short i = 0; i < 8; i++) {
            DmxSimple.write(i + 1 , ((altScene[i] + (((aktScene[i] - altScene[i])/255)*fadePosition))*masterDimmer) / 100 );
          }
          fadePosition = fadePosition + 1;
          timeFade = millis();
        }
        else if (fadeTime <=0 ) {
          for (short i = 0; i < 8; i++) {
            DmxSimple.write(i + 1 , ((aktScene[i])*masterDimmer) / 100 );
          }
          fadePosition = 256;
        }


      }
      else{
        trackRE(2, 0, 20, 1);
      }
      break;
    case 3:
      trackRE(3, 0, 20, 1);
      break;
  }

  buttonPress();            // Select Button aktualisieren

  if (action == true){      // Aktion beim drücken des Select Buttons

    // Zurück (Szene hinzufügen, löschen, abrufen; Chaser Abrufen)
    if ( ((status[1] == 3 && statusebene == 1) || (status[2] == 20 && statusebene == 2)) && (status[0] >= 1 && status[0] <= 4) ){
      if (statusebene <= 0){
        statusebene = 0;
      }
      else{
        statusebene = statusebene - 1;
      }
    }
    // auswählen (Szene hinzufügen, löschen, abrufen; Chaser Abrufen)
    else if (status[0] >= 1 && status[0] <= 4) {
      // Chaserabruf Zurück
      if (status[0] == 4 && statusebene >= 2){
        statusebene = statusebene - 2;
      }

      if (statusebene >= 2){  // Aktionsebene
        switch (status [0]){
          case 1: // Scene hinzufügen
            for (uint8_t i = 0; i < 8; i++) {
              EEPROM.update((status[1]*200) + status[2]*8 + i, DmxSimple.getValue(i + 1));  // Erste 8 DMX Werte in EEPROM speichern
            }
            status[0] = 0;  // Manuell
            statusebene = 0;// Manuell auswahl auf false --> wird im Abschnitt unten umgetriggerd
            break;
          case 2: // Scene löschen
            for (uint8_t i = 0; i < 8; i++) {
              EEPROM.update((status[1]*200) + status[2]*8 + i, 0);  // Erste 8 DMX Werte in EEPROM auf 0 setzen --> nur Null scenen werden ignoriert
            }
            break;
          case 3: // Scene Abrufen
            for (uint8_t i = 0; i < 8; i++) {
              DmxSimple.write(1 + i, EEPROM.read((status[1]*200) + status[2]*8 + i));  // 8 DMX Werte aus EEPROM lesen und ausgeben
            }
            break;
        }
      }
      else {
        statusebene = statusebene + 1;
      }
    }

    // Manuell
    if (status[0] == 0) {
      if (statusebene == 0){
        statusebene = 1;
      }
      else{
        statusebene = 0;
      }
    }
    // Einstellungen
    if (status[0] == 5){
      switch (statusebene) {
        case 0: // Auswahl des Startmodus Menueintrag
          statusebene = statusebene + 1;
          status[1] = 0;
          status[2] = 0;
          status[3] = 0;
          break;
        case 1: // Auswahl zwischen Manuell, Scene, Chaser und Zurück
          if (status[1] == 3){ // Zurück zum Hauptmenu
            statusebene = 0;
          }
          else if (status[1] == 0){ // Manuell ausgewählt
            for (uint8_t i = 0; i < 4; i++) {
              EEPROM.update(600 + i, 0);  // Modus speichern
            }
            EEPROM.update(610, 1);  // Statusebene speichern
            statusebene = 0;
          }
          else{
            statusebene = statusebene + 1;
          }
          break;
        case 2: // Auswahl des Chasers
          if (status[2] == 3) {     // Zurück
            statusebene = statusebene - 1;
          }
          else if (status[1] == 2) {     // Chaserauswahl
                                         // Chaser als modus speichern
            uint8_t startwerte[4] = {4, status[2], 0, 0};
            for (size_t i = 0; i < 4; i++) {
              EEPROM.update(600 + i, startwerte[i]);
            }
            EEPROM.update(610, 1);
            statusebene = 0;
          }
          else{   // Weiterleitung zur Scenenauswahl
            statusebene = statusebene + 1;
            status[3] = 0;
          }
          break;
        case 3: // Auswahl der Scene
          if (status[3] == 20){ // Zurück
            statusebene = statusebene - 1;
          }
          else{
            uint8_t werteStart[4] = {3, status[2], status[3], 0};
            for (size_t i = 0; i < 4; i++) {
              EEPROM.update(600 + i, werteStart[i]);
            }
            EEPROM.update(610, 2);
            statusebene = 0;
          }
          break;

      }

    }



    action = false;
  }

  if (printRefresh == true && millis()-time > lcdUpdateTime) {   // LCD updaten
    lcd.clear();
    static String menueintraege[] = {"Manuell", "Scene hinzuf\365gen", "Scene l\357schen", "Scene abrufen", "Chaser abrufen", "Einstellungen"};
    static String chaserAddIcon[] = {"+", "-", "#", "~"};
    static String chaserauswahl[] = {"Chaser 1", "Chaser 2", "Chaser 3", "Zur\365ck"};
    static String einstellungen[] = {menueintraege[0], menueintraege[3], menueintraege[4], chaserauswahl[3]};

    switch (statusebene) {
      case 0: //Menuebene
        lcd.print("Hauptmenu");
        lcd.setCursor(0, 1);
        lcd.print(menueintraege[status[0]]);
        break;
      case 1: // Modusebene/Chaserauswahl
        if (status[0] >= 1 && status[0] <= 4){     // Chaser Auswahl
          lcd.print(chaserAddIcon[status[0]-1]);
          lcd.print(" Chaser Auswahl");
          lcd.setCursor(0, 1);
          lcd.print(chaserauswahl[status[1]]);
        }
        else if (status[0] == 0){  // Manuell
          lcd.print(status[3]+1);
          lcd.print(": ");
          lcd.setCursor(4, 0);
          lcd.print(DmxSimple.getValue(status[3]+1));
          lcd.setCursor(8, 0);
          lcd.print(status[3]+2);
          lcd.print(": ");
          lcd.setCursor(12, 0);
          lcd.print(DmxSimple.getValue(status[3]+2));
          lcd.setCursor(0, 1);
          lcd.print(status[3]+3);
          lcd.print(": ");
          lcd.setCursor(4, 1);
          lcd.print(DmxSimple.getValue(status[3]+3));
          lcd.setCursor(8, 1);
          lcd.print(status[3]+4);
          lcd.print(": ");
          lcd.setCursor(12, 1);
          lcd.print(DmxSimple.getValue(status[3]+4));
        }
        else {                      // Einstellungen
          lcd.print("Startmodus");
          lcd.setCursor(0, 1);
          lcd.print(einstellungen[status[1]]);
        }
        break;
      case 2: // Scenenauswahl
        if (status[0] >= 1 && status[0] <= 3){     // Scenen Auswahl
          lcd.print(chaserAddIcon[status[0]-1]);
          lcd.print(" Scene Auswahl");
          lcd.setCursor(0, 1);
          if (status[2] != 20){
            lcd.print("Ch");
            lcd.print(status[1]+1);
            lcd.print(" Scene: ");
            lcd.print(status[2]+1);
          }
          else{
            lcd.print(chaserauswahl[3]);
          }
        }
        if (status[0] == 4){      // Chasermodus
          static String dirArray[4] = {">>>", "<<<", "> <", " Z "};
          lcd.print("T-s T-f Dim ");
          lcd.print(status[1]+1);
          lcd.print("#");
          lcd.print(status[2]+1);
          lcd.setCursor(0, 1);
          lcd.print(sceneSpeed/10);
          lcd.print("s");
          lcd.setCursor(4, 1);
          lcd.print(fadeTime/2);
          lcd.print("s");
          lcd.setCursor(8, 1);
          lcd.print(masterDimmer);
          lcd.print("%");
          lcd.setCursor(13, 1);
          lcd.print(dirArray[richtung]);
        }
        if (status[0] == 5){      // Einstellungen Chaser auswahl
          lcd.print(einstellungen[status[1]]);
          lcd.setCursor(0, 1);
          lcd.print(chaserauswahl[status[2]]);
        }
        break;
      case 3:
        if (status[0] == 5){
          lcd.print("Scene Auswahl");
          lcd.setCursor(0, 1);
          if (status[3] != 20){
            lcd.print("Ch");
            lcd.print(status[2]+1);
            lcd.print(" Scene: ");
            lcd.print(status[3]+1);
          }
          else{
            lcd.print(chaserauswahl[3]);
          }
        }

    }

    printRefresh = false;
    time = millis();
  }


}
