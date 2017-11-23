import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class

Minim minim;
AudioPlayer song;
AudioInput input;

void setup()
{
  size(512, 200);

  // always start Minim first!
  minim = new Minim(this);

  // specify 512 for the length of the sample buffers
  // the default buffer size is 1024
  // song = minim.loadFile("mysong.wav", 512);
  // song.play();

  input = minim.getLineIn(); 
  input.setGain(60);


  // an input needs to know how 
  // long the audio buffers it will be analyzing are
  // and also needs to know 
  // the sample rate of the audio it is analyzing
  //fft = new FFT(input.bufferSize(), input.sampleRate());

  println (Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  background(0);

  // println(input.getGain());

  for (int i = 0; i < input.bufferSize() - 1; i++)
  {
    line( i, 50 + input.left.get(i)*50, i+1, 50 + input.left.get(i+1)*50 );
    line( i, 150 + input.right.get(i)*50, i+1, 150 + input.right.get(i+1)*50 );
  }
  // first perform a forward input on one of song's buffers
  // I'm using the mix buffer
  // but you can use any one you like
  //  input.forward(input.mix);


  int nbrBande = input.bufferSize()/4;


  float totalAmplitude = 0;

  // Groupe 1
  for (int numeroBande = 0; numeroBande < nbrBande; numeroBande += 1)
  {
    totalAmplitude += input.left.get(numeroBande)*50;
    //  println(input.getBand(numeroBande));
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
  /*
  print("Moyenne1: ");
   print(moyenneAmplitude1);
   
   print(" Moyenne2: ");
   print(moyenneAmplitude2);
   
   print(" Moyenne3: ");
   print(moyenneAmplitude3);
   
   print(" Moyenne4: ");
   print(moyenneAmplitude4);
   
   println("");
   */

  // Affichage
  stroke(255);
  line(1, height- moyenneAmplitude1*10, 10, height - moyenneAmplitude1*10);
  line(11, height- moyenneAmplitude2*10, 20, height - moyenneAmplitude2*10);
  line(21, height- moyenneAmplitude3*10, 30, height - moyenneAmplitude3*10);
  line(31, height- moyenneAmplitude4*10, 40, height - moyenneAmplitude4*10);
  fill(128);

  // Envoyer a l'arduino
  // arduino.servoWrite(9, angle

  int angleAmp1 = int(map(moyenneAmplitude1, 0, 2, 0, 90));
  int angleAmp2 = int(map(moyenneAmplitude2, 0, 1, 0, 90));
  
  println(angleAmp2);
  
  angleAmp1 = int(map(angleAmp1, -100, 100, 0, 90));
  angleAmp2 = int(map(angleAmp2, -300, 300, 0, 90));
  
  myPort.write("a"+angleAmp1+"\n");
  myPort.write("b"+angleAmp2+"\n");
}

void serialEvent(Serial p) {
  String message = myPort.readStringUntil(13);
  if (message != null) {
   // println(message);
  }
}