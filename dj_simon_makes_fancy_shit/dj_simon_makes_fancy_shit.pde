import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

// directions for the value-fade
int dir1 = -1;
int dir2 = -1;
int dir3 = -1;

// midi notes
int midiNote1 = 0;
int midiNote2= 1;
int midiNote3 = 2;

int value1 = 0;
int value2 = 60;
int value3 = 126;

int someVar = 0;

void setup() {
  size(400, 400);


  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, "Virtual Midi"); //  New MidiBus, no input device output: Virtual Midi.
}

void draw() {
  fill(255);
  background(0, 0, 255);
  textSize(50);
  text("Midi Note: "+midiNote1, 0, 50); 
  text("Intensity: "+value1, 0, 100); 
  text("Midi Note: "+midiNote2, 0, 150); 
  text("Intensity: "+value2, 0, 200); 
  text("Midi Note: "+midiNote3, 0, 250); 
  text("Intensity: "+value3, 0, 300); 

sendMidi();

}

void sendMidi(){
fadeNote0();
fadeNote1();
fadeNote2();

  myBus.sendControllerChange(someVar, midiNote1, value1); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiNote2, value2); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiNote3, value3); // Send a controllerChange

}
void fadeNote0(){
if (value1 >= 127 || value1 <=0) {
   dir1 = dir1 *-1;}
   value1 += dir1;
}

void fadeNote1(){
if (value2 >= 127 || value2 <=0) {
   dir2 = dir2 *-1;}
   value2 += dir2;
}

void fadeNote2(){
if (value3 >= 127 || value3 <=0) {
   dir3 = dir3 *-1;}
   value3 += dir3;
}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}