## Imprimante-de-sons

![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/2.jpg)

*Un photos-boots des voix, un rendu visuel du son.*

L'utilisateur parle dans le micro, une capsule de papier absorbe 4 couleurs d’encres selon l’intonation de cet utilisateur et créait ainsi un motif unique (correspondant à sa voix).

Son : lien avec les conférences, les speakers, la parole et donc les différents types de voix. Chaque intonation de voix est différente ; la conférence accueillant des venues du monde entier, il pourrait être intéressant de faire prononcer aux utilisateurs des phrases incongrues de la poésie française. Une capsule de papier sur lequel serait déversée de l’encre selon l’intonation de la voix serait remit à l’utilisateur, comme un «diplôme». 

## Le dispositif

# LE MICRO
L’utilisateur prononce dans le micro la phrase qui s’affiche à l’écran. Le son est analysé et divisé en quatre types de fréquences.

# LE TEXTE
Le texte est généré aléatoirement sur l’écran. Ce sont des phrases de la poésie française avec des mots qui peuvent paraître particuliers.

*Un gros matou roux qu’ils avaient
d’abord appelé Leroux, puis Gaston,
puis Chéribibi, en enfin en ultime
aphérèse, Ribibi.*


# LE RENDU
Les 4 types de fréquences analysées correspondent aux 4 encres. Lorsque la fréquence est atteinte, la pipette d’encre lui correspondant effectue une rotation et déverse de l’encre sur une capsule de papier absorbant. Un motif particulier se créer ainsi sur chaque capsuler de papier selon l’intonation de l’utilisateur.

## Matériel & software requis

* Processing 
* Arduino 
* 2 servomoteurs / Tige rigide / pipettes / encres 
* Scotch
* Papier absorbant

## Analyse du son 

### 1. Diviser le son en 4 types de fréquences 

Il faut diviser le son en 4 types de fréquence afin de récupérer 4 données qui activeront les 4 servomoteur

```
 // Groupe 1
  for (int numeroBande = 0; numeroBande < nbrBande; numeroBande += 1)
  {
    totalAmplitude += input.left.get(numeroBande)*50;
  }
  float moyenneAmplitude1 = totalAmplitude/nbrBande;

  // Groupe 2
  totalAmplitude = 0;
  for (int numeroBande = nbrBande; numeroBande < 2*nbrBande; numeroBande += 1)
  {
    totalAmplitude += input.left.get(numeroBande)*50;
  }
  float moyenneAmplitude2 = totalAmplitude/nbrBande;
  moyenneAmplitude2 = moyenneAmplitude2 * 4;

  // Groupe 3
  totalAmplitude = 0;
  for (int numeroBande = 2*nbrBande; numeroBande < 3*nbrBande; numeroBande += 1)
  {
    totalAmplitude += input.left.get(numeroBande)*50;
  }
  float moyenneAmplitude3 = totalAmplitude/nbrBande;
  moyenneAmplitude3 = moyenneAmplitude3 * 8;

  // Groupe 4
  totalAmplitude = 0;
  for (int numeroBande = 3*nbrBande; numeroBande < 4*nbrBande; numeroBande += 1)
  {
    totalAmplitude += input.left.get(numeroBande)*50;
  }
  float moyenneAmplitude4 = totalAmplitude/nbrBande;
  moyenneAmplitude4 = moyenneAmplitude4 * 16;
```

Faire de ces résultats des données exploitable par l'arduino

```
  myPort.write("a"+angleAmp1+"\n");
  myPort.write("b"+angleAmp2+"\n");

```

### 2. Définir un angle sur lequel les servo pourront s'actionner 

```
 int angleAmp1 = int(map(moyenneAmplitude1, 0, 2, 0, 90));
  int angleAmp2 = int(map(moyenneAmplitude2, 0, 1, 0, 90));
 ```
### 3. Lier l'arduino à processing et inversement

Processing : 

```
  void serialEvent(Serial p) {
  String message = myPort.readStringUntil(13);
  if (message != null) 
```
  
  Arduino : 
  
  ```
    if (Serial.available()) {
    val = Serial.read();
    val = int(val);
  ```

# Le montage
![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/3.jpg)

## Schéma Arduino
![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/2_servo_bb.jpg)

