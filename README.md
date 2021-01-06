---
output:
  pdf_document: default
  html_document: default
---
# VBZ_Pktl_vergleich

Simpler Vergleich der Pünktlichkeit der Verkehrsbetriebe Zürich (VBZ) mit anderen Pünktlichkeitsdefinitionen. Bspw. der Deutschen Bahn (DB) oder den der Schweizer Bundesbahnen (SBB).

Die Idee basiert auf einer Aussage in [diesem Artikel](https://www.wiwo.de/unternehmen/dienstleister/ice-puenktlichkeit-die-deutsche-bahn-hat-ein-sylt-problem/26753724.html), nachdem bei der Deutschen Bahn im Idealfall 93% Pünktlichkeit als maximal möglicher Wert bestimmt wurde.

## Hintergrund

Die Verkehrsbetiebe Zürich (VBZ) veröffentlichen u.a. über die [Open Data Platform der Stadt Zürich](https://data.stadt-zuerich.ch/) ihre effektiven Fahrzeiten (Soll-Ist-Fahrplandaten, sekundengenau) als Open Government Data (OGD).
Anhand dieser Daten lassen sich also beliebige Pünktlichkeitswerte nach beliebigen Pünktlichkeitsdefinitionen berechnen.

Anders gesagt: Wie hoch wäre die Pünktlichkeit der VBZ, wenn diese eine ähnliche Definition wie die DB oder SBB anwenden würde?


## Datengrundlage
- Messdaten vom 05.Jan.2020 - 26.Dez.2020  
- Quelle: [Stadt Zürich Open Data](https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd)  
- Alle Fahrzeuge (Tram, Trolley, Bus) der VBZ und dessen Transportbeauftragten  


## Methodik
- Berechnung der Verspätung anhand des Vergleichs der Soll-Ankunftszeit und der Ist-Ankunftszeit   
- Bestimmung des Prozentwertes der Pünktlichkeit nach unterschiedlichen Definitionen   

## Ergebnis

Wie Pünktlich wären die VBZ bei unterschiedlichen Pünktlichkeitsmessungen?

Definition | Verspätet ab | Pünktlichkeitswert
------------ | ------------- | ------------- 
VBZ | ab 2 min | 90.7% 
SBB | ab 3 min | 96.0%
DB | ab 6 min | 99.4 %

## Abgrenzungen/Diskussion

Die Pünktlichkeitswerte 2020 sind bei den VBZ höher als üblich aufgrund der Pandemiesituation. So gab es zeitweise deutlich weniger Verkehr auf den Strassen, was zu weniger Behinderungen und damit einer erhöhten Pünktlichkeit führt.

Es sind Abweichungen zu den offiziell publizierten Daten der Verkehrsbetriebe Zürich möglich.
- Keine saubere Abgrenzung zum Fahrplanjahr 2020 (08.Dez.2019 - 12.Dez.2020)  
- Nur Betrachtung von Ankünften, die VBZ selbst definieren auch stark verfrühte Abfahrten als Unpünktlich  


Ebenso ist die Berechnung stark vereinfacht und detailiertere Abgrenzungen können das Ergebnis sowohl positiv, als auch negativ beeinflussen.


Selbstverständlich ist der Vergleich VBZ zur DB bzw. zur SBB nur bedingt sinnvoll, da sowohl betrieblich, als auch infrastrukturell deutliche Unterschiede bestehen.
So ist u.a. der Laufweg der einzelnen Fahrzeuge bei den VBZ selbstredend deutlich kürzer und die Betriebsabläufe sind i.d.R. weniger komplex. Allerdings fahren die Fahrzeuge der VBZ zu nicht unwesentlichen Teilen im normalen Strassenverkehr mit den entsprechenden Begleiterscheinungen wie bspw. Stau. 
