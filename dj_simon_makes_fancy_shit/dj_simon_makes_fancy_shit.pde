import themidibus.*; //Import the library
import controlP5.*;

//////////////  Instantiating new instance of class /////////////////

MidiBus myBus; // The MidiBus


//////////////  Declaring varibles  /////////////////
int offset = 20;
int delayTime = 150;        //gets input from textfield
int dir1 = -1;
int dir2 = -1;
int dir3 = -1;        // direction on first, second and third midi output

int midiNote1 = 0; // defining midi output Note for first midi output
int midiNote2= 1;  // defining midi output Note for second midi output
int midiNote3 = 2; // defining midi output Note for third midi output

int value1 = 0;        // defining start value for first midi output
int value2 = 63;        // defining start value for second midi output
int value3 = 126;      // defining start value for third midi output

int someVar = 0;      // no one know how the shizzle this came into play

int fill1, fill2, fill3; // fill for visuals
int edgeRound = 20;
int leftMarginBtn = 300;
float x = leftMarginBtn;
float y = 400;
float w = 160;
float h = 70

  ;
boolean buttonClicked = false;
void setup() {
  size(700, 500); //size of window

  textFieldInput();  // call function textFieldInput();

  MidiBus.list();   // List all available Midi devices on STDOUT. This will show each device's index and name.

  myBus = new MidiBus(this, -1, "Virtual Midi"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}



void draw() {
  background(45);  // background colour

  fill(20);
  noStroke();
  rect(250, 0, 450, 500);

  textOnScreen();        // call textOnScreen() function
  pauseBtn();

  playBtn();
  visualizer();          // display visuals
} 

void pauseBtn() {
  stroke(127);
  strokeWeight(3);
  fill(255, 200, 200);
  rect(x, y, w, h, edgeRound);
  fill(0);
  text("PAUSE", 345, 445); 

  if (mousePressed) {
    if (mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h) {
      buttonClicked = true;
    } else {
    }
  }

  if (buttonClicked) {
  } else {
    sendMidi();            // call sendMidi() function
  }
}

void playBtn() {
  stroke(127);
  strokeWeight(3);
  fill(200, 255, 200);
  rect(x+190, y, w, h, edgeRound);
  fill(0);
  text("PLAY", 540, 445); 
  if (mousePressed) {
    if (mouseX>x+190 && mouseX <x+190+w && mouseY>y && mouseY <y+h) {
      buttonClicked = false;
    } else {
    }
  }
}
void visualizer() {
  int rectLength = 350;
  int rectHeight = 90;
  int offset = 125;

  strokeWeight(3);
  stroke(127);
  fill1 = value1*2;  
  fill2 = value2*2;  
  fill3 = value3*2;  


  fill(fill1); 
  rect (leftMarginBtn, 20, rectLength, rectHeight, edgeRound);
  fill(fill2);
  rect (leftMarginBtn, 20 + offset, rectLength, rectHeight, edgeRound);
  fill(fill3);
  rect (leftMarginBtn, 20 + 2*offset, rectLength, rectHeight, edgeRound);
}



void textOnScreen() {
  fill(250);
  textSize(30);
  text("Midi Note: "+midiNote1, offset, 50); 
  text("Intensity: "+value1, offset, 90); 
  text("Midi Note: "+midiNote2, offset, 175); 
  text("Intensity: "+value2, offset, 215); 
  text("Midi Note: "+midiNote3, offset, 300); 
  text("Intensity: "+value3, offset, 340); 
  textSize(20);
  text("Current delay: "+delayTime+" ms", offset, 390); 

  //text("Enter delay time (ms)", 110, 400);
}



void sendMidi() {
  fadeNote0();
  fadeNote1();
  fadeNote2();
  delay(delayTime);

  myBus.sendControllerChange(someVar, midiNote1, value1); // Sends midi out (first output)
  myBus.sendControllerChange(someVar, midiNote2, value2); // Sends midi out (second output)
  myBus.sendControllerChange(someVar, midiNote3, value3); // Sends midi out (third output)
}



void fadeNote0() {
  if (value1 >= 127 || value1 <=0) {
    dir1 = dir1 *-1;
  }
  value1 += dir1;
}



void fadeNote1() {
  if (value2 >= 127 || value2 <=0) {
    dir2 = dir2 *-1;
  }
  value2 += dir2;
}

void fadeNote2() {
  if (value3 >= 127 || value3 <=0) {
    dir3 = dir3 *-1;
  }
  value3 += dir3;
}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}



void textFieldInput() {
  ControlP5 cp5;
  String textFieldName = "speed";
  PFont font = createFont("arial", 20);
  cp5 = new ControlP5(this);

  int y = 400;
  int spacing = 60;
  cp5.addTextfield("delay time (ms)")
    .setPosition(offset, y)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255))
    ;
  y += spacing;


  textFont(font);
}



void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
    delayTime = Integer.parseInt(theEvent.getStringValue());
    println(delayTime);
  }
}