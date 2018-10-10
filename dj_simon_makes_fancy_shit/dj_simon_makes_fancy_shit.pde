import themidibus.*; //Import the library
import controlP5.*;

//////////////  Instantiating new instance of class /////////////////

MidiBus myBus; // The MidiBus


//////////////  Declaring varibles  /////////////////

int delayTime;        //gets input from textfield
int dir1 = -1;        // direction on first midi output
int dir2 = -1;        // direction on second midi output
int dir3 = -1;        // direction on third midi output

int midiChannel1 = 0; // defining midi output channel for first midi output
int midiChannel2= 1;  // defining midi output channel for second midi output
int midiChannel3 = 2; // defining midi output channel for third midi output

int value1 = 0;        // defining start value for first midi output
int value2 = 63;        // defining start value for second midi output
int value3 = 126;      // defining start value for third midi output

int someVar = 0;      // no one know how the shizzle this came into play

void setup() {
  size(400, 400);

textFieldInput();
  
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, "Virtual Midi"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  fill(255);
  background(0, 0, 255);
  textSize(50);
  text("Midi Channel: "+midiChannel1, 0, 50); 
  text("Intensity: "+value1, 0, 100); 
  text("Midi Channel: "+midiChannel2, 0, 150); 
  text("Intensity: "+value2, 0, 200); 
  text("Midi Channel: "+midiChannel3, 0, 250); 
  text("Intensity: "+value3, 0, 300); 

  //  Button(int xp, int yp, int s, String text_) {

  sendMidi();
} 



void sendMidi() {
  fadeChannel0();
  fadeChannel1();
  fadeChannel2();
  delay(delayTime);

  myBus.sendControllerChange(someVar, midiChannel1, value1); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiChannel2, value2); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiChannel3, value3); // Send a controllerChange
}
void fadeChannel0() {
  if (value1 >= 127 || value1 <=0) {
    dir1 = dir1 *-1;
  }
  value1 += dir1;
}

void fadeChannel1() {
  if (value2 >= 127 || value2 <=0) {
    dir2 = dir2 *-1;
  }
  value2 += dir2;
}

void fadeChannel2() {
  if (value3 >= 127 || value3 <=0) {
    dir3 = dir3 *-1;
  }
  value3 += dir3;
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
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


  cp5 = new ControlP5(this);

  int y = 350;
  int spacing = 60;
    cp5.addTextfield("Delay time")
       .setPosition(100,y)
       .setSize(200,40)
       .setFont(font)
       .setFocus(true)
       .setColor(color(255))
     y += spacing;
  

  textFont(font);

}



void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
            delayTime = Integer.parseInt(theEvent.getStringValue());
            println(delayTime);
  }
}