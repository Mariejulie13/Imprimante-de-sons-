## Printer-of-sound

![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/2.jpg)

*A photos-boots of voice, a visual rendering of the sound.*

The user speaks in the microphone, a paper absorbs 4 colors of ink according to the intonation of this user and thus creates a unique pattern (corresponding to his voice).

Sounds: link with conferences, speakers, speech and therefore different types of voice. Each voice intonation is different; the conference welcomes guests from around the world, it might be interesting to have users pronounce incongruous sentences of French poetry. A capsule of paper on which ink would be poured according to the intonation of the voice would be given to the user like a "diploma".

## The device

# THE MICRO
The user pronounces in the microphone the sentence that appears on the screen. The sound is analyzed and divided into four types of frequencies.

# THE TEXTE
The text is generated randomly on the screen. These are sentences of French poetry with words that may seem special.

*Un gros matou roux qu’ils avaient
d’abord appelé Leroux, puis Gaston,
puis Chéribibi, en enfin en ultime
aphérèse, Ribibi.*

Example :

```
String[] sujets = {
 "Le pape", "Ma mere", "Ton père","Ton meilleur ami","Le type à côté de toi","Ton voisin", "Le monde", "La mer" };
String[] verbes = {
 "est","","n'est plus","devient", "semble","a cessé d'être","sera demain","trouvera" };
String[] complements = {
 "un chic type","hostile","ton meilleur ami","ton seul choix","ta seule famille","la mort","une feuille","un logiciel" };
PFont mapolice;

void setup(){
 size(700,200);
 // declarer la police 
 mapolice = loadFont("DIN-Light-48.vlw"); 
 textFont(mapolice,24);
 textAlign(CENTER);
 smooth();
 fill(255);
}

void draw(){
 background(0);
 // choisir un sujet
 float alea=random(0,sujets.length);
 int lesujet=int(alea);

 // choisir un verbe
 alea=random(0,verbes.length);
 int leverbe=int(alea);

 // choisir un verbe
 alea=random(0,complements.length);
 int lecomplement=int(alea);
 
 // assembler le tout et afficher
 String lasentence=sujets[lesujet] + " " + verbes[leverbe] + " " + complements[lecomplement];
 text(lasentence, width/2, 100); 
 
 // une pause pour lire la phrase
 delay(3000);
}
```

# RENDERING 

The 4 types of frequencies analyzed correspond to the 4 inks. When the frequency is reached, the corresponding ink pipette rotates and pours ink onto a paper. A particular pattern is created on each paper according to the intonation of the user.

## Hardware & software required

* Processing 
* Arduino 
* 2 servomoteurs / Rigid stem / pipettes / Inks 
* Scotch
* Absorbent paper

## Sound Analysis

### 1.Divide the sound into 4 types of frequencies

We must divide the sound into 4 types of frequency in order to recover 4 data that will activate the 4 servomotors

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

Make these results data usable by the arduino

```
  myPort.write("a"+angleAmp1+"\n");
  myPort.write("b"+angleAmp2+"\n");

```

### 2. Define an angle on which the servo can operate

```
 int angleAmp1 = int(map(moyenneAmplitude1, 0, 2, 0, 90));
  int angleAmp2 = int(map(moyenneAmplitude2, 0, 1, 0, 90));
 ```
### 3. Link the arduino to processing and vice versa

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

# Mounting
![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/3.jpg)

## Schema Arduino
![](https://github.com/Mariejulie13/Imprimante-de-sons-/blob/master/assets/2_servo_bb.jpg)

