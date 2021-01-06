rm(list=ls())
gc()

##### Description: 
#     Calculate punctuality of the traveltimedata of Verkehrsbetriebe Zürich (VBZ) and compare
#     different definitions of punctuality like those from Deutsche Bahn (DB) or Schweizerische
#     Bundesbahnen (SBB)
#
#     Script mostly based on the OGD-Example-script from Verkehrsbetriebe Zürich (VBZ)
#     https://github.com/VerkehrsbetriebeZuerich/ogd_examples_R
#     Data downloaded from the open data platform of the city of Zurich
#     https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd


##### Author: christophbaur https://github.com/christophbaur

##### Date: 06.01.2021


#________________________________________________________________
#####                   Setup                               #####
#________________________________________________________________

# Libraries
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)


# Input-path 
input_path <- ("C:/Users/Chris/Documents/R/VBZ_Pktl_vergleich/Daten/Input/")


#_________________________________________________________________
#####                 Main                                   #####
#_________________________________________________________________


#### >Load the data ####
# You will find the data sets at 
# https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd

#Matchingtables
haltepunkt <- read_csv(paste0(input_path,"haltepunkt.csv"))

haltestelle <- read_csv(paste0(input_path,"haltestelle.csv"))


#Main table

#how many "fahrzeiten*" files exists in folder?
file_list <- list.files(input_path,
                        pattern = "fahrzeiten")

#for each file tmp loading, extract the needed information, remove tmp
#Hintergrund: begrenzter RAM
for (file in file_list){
  # if the merged dataset does exist, append to it
  if (exists("fahrzeiten")){
    #temporär Daten laden
    temp_dataset <- read_csv(paste0(input_path,file))
    
    #weitere Berechnungen
    temp_dataset <- temp_dataset%>%
      #Jahr/Kalenderwoche berechnen
      mutate(jahr=year(as.Date(betriebsdatum, format="%d.%m.%y")),
             kw=isoweek(as.Date(betriebsdatum, format="%d.%m.%y")))%>%
      #Ankunftsverspätung errechnen
      mutate(gap_arr=(ist_an_nach1-soll_an_nach))%>%
      #kategorisieren
      mutate(punct_cat = case_when(gap_arr<0 ~ "lower_0min",
                                   gap_arr>=0 & gap_arr <60 ~ "0_1min",
                                   gap_arr>=60 & gap_arr <120 ~ "1_2min",
                                   gap_arr>=120 & gap_arr <180 ~ "2_3min",
                                   gap_arr>=180 & gap_arr <240 ~ "3_4min",
                                   gap_arr>=240 & gap_arr <300 ~ "4_5min",
                                   gap_arr>=300 & gap_arr <360 ~ "5_6min",
                                   gap_arr>=360  ~ "higher_6min"))%>%
      #aggregieren
      group_by(jahr, kw, punct_cat)%>%
      summarise(anzahl=n())%>%
      ungroup()
    
    #hinzufügen zu existierendem Datensatz
    fahrzeiten<-rbind(fahrzeiten, temp_dataset)
    #temporäre Daten löschen
    rm(temp_dataset)
  }
  
  # if the merged dataset doesn't exist, create it
  if (!exists("fahrzeiten")){
    #Daten laden
    fahrzeiten <- read_csv(paste0(input_path,file))
    
    #weitere Berechnungen
    fahrzeiten <- fahrzeiten%>%
      #Jahr/Kalenderwoche berechnen
      mutate(jahr=year(as.Date(betriebsdatum, format="%d.%m.%y")),
             kw=isoweek(as.Date(betriebsdatum, format="%d.%m.%y")))%>%
      #Ankunftsverspätung errechnen
      mutate(gap_arr=(ist_an_nach1-soll_an_nach))%>%
      #kategorisieren
      mutate(punct_cat = case_when(gap_arr<0 ~ "lower_0min",
                                   gap_arr>=0 & gap_arr <60 ~ "0_1min",
                                   gap_arr>=60 & gap_arr <120 ~ "1_2min",
                                   gap_arr>=120 & gap_arr <180 ~ "2_3min",
                                   gap_arr>=180 & gap_arr <240 ~ "3_4min",
                                   gap_arr>=240 & gap_arr <300 ~ "4_5min",
                                   gap_arr>=300 & gap_arr <360 ~ "5_6min",
                                   gap_arr>=360  ~ "higher_6min"))%>%
      #aggregieren
      group_by(jahr, kw, punct_cat)%>%
      summarise(anzahl=n())%>%
      ungroup()
               
  }
  
}

#### Pünktlichkeit im Netz, gesamter Zeitraum #### 
pktl_gesamt <- fahrzeiten%>%
  #group per punctual category
  group_by(punct_cat)%>%
  #sum it up
  summarise(anzahl=sum(anzahl))%>%
  #and create percentage value
  mutate(percentage=100*(anzahl/sum(anzahl)))

#gemäss vereinfachter Definition VBZ
#ab 2 min verspätet
#(ohne verfrühte Abfahrten als unpünktlich zu zählen)
pktl_vbz <- pktl_gesamt%>%
  filter(punct_cat=="lower_0min" | 
           punct_cat=="0_1min" |
           punct_cat=="1_2min")%>%
  summarise(prozent=sum(percentage))

  
# gemäss Definition Deutsche Bahn
#ab 6 min
pktl_db <- pktl_gesamt%>%
  filter(!punct_cat=="higher_6min")%>%
  summarise(prozent=sum(percentage))
  
# gemäss Definition SBB
#ab 3 min
pktl_sbb <- pktl_gesamt%>%
  filter(punct_cat=="lower_0min" | 
           punct_cat=="0_1min" |
           punct_cat=="1_2min" |
           punct_cat=="2_3min")%>%
  summarise(prozent=sum(percentage))

