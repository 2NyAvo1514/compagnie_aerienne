# Compagnie aerienne

Projet transversal S5 - S3

## Regles de gestion

- Il y a plusieurs avions .
- Chaque avion a sa capacité Un vol est défini par son aéroport d'embarquement et son aéroport de débarquement .
- Un vol peut être effectué par plusieurs avions 
- Un vol peut être effectué plusieurs fois dans la journée 
- Un vol peut être effectué sur plusieurs jours

## Fonctionnalite(s)

. Un client veut acheter des places pour un vol de Aéroport de TNR à l'aéroport de Nosy Be pour le 12 janvier à 12h
. Un avion possede des places de différentes classes (économique,première)
Pour un vol Tana - Nosy Be , place première classe : 1.200.000 Ar , place économique : 700.000 Ar
Donner la valeur maximale qu'un avion peut generer pour un vol
## Deploiement local

### 1 - Prerequis

- Java 17
- PostgreSQL
- Maven

### 2 - Telecharger le projet

Recuperer le fichier .ZIP du projet puis extraire

### 3 - Pour lancer le projet

Executer :
``` bash
mvn clean install
```
Puis :
``` bash
mvn springboot:run
```

### 4 - Des questions ?

-> Envoyez un message !