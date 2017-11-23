#include <Servo.h> //on importe la bibliothèque Servo

#define INCR1 1
#define INCR2 2

Servo servo1, servo2;

// les consignes de position
int cons1 = 0;
int cons2 = 0;

// l'angle courant
int angle1=0;
int angle2 = 0;

int pinServo1=8; // variable pour stocker le pin pour la commande
int pinServo2=13; // variable pour stocker le pin pour la commande


Servo leServo1; // on définit un objet Servo nommé leServo
Servo leServo2; // on définit un objet Servo nommé leServo

void setup() {
  leServo1.attach(pinServo1); // on relie l'objet au pin de commande
  leServo2.attach(pinServo2); // on relie l'objet au pin de commande
  Serial.begin(9600);
}

int val = 0;

void loop() {

  if (Serial.available()) {
    val = Serial.read();
    val = int(val);
  }
  
  leServo2.write(val); 
 // leServo2.write(val); 
 
}

