import themidibus.*; //Import the library
int dir1 = -1;
int dir2 = -1;
int dir3 = -1;
MidiBus myBus; // The MidiBus
int midiChannel1 = 0;
int midiChannel2= 1;
int midiChannel3 = 2;

int value1 = 0;
int value2 = 63;
int value3 = 126;

int someVar = 0;

void setup() {
  size(400, 400);


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

sendMidi();

}

void sendMidi(){
  fadeChannel0();
  fadeChannel1();
  fadeChannel2();
      delay(100);

  myBus.sendControllerChange(someVar, midiChannel1, value1); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiChannel2, value2); // Send a controllerChange
  myBus.sendControllerChange(someVar, midiChannel3, value3); // Send a controllerChange

}
void fadeChannel0(){
if (value1 >= 127 || value1 <=0) {
   dir1 = dir1 *-1;}
   value1 += dir1;
}

void fadeChannel1(){
if (value2 >= 127 || value2 <=0) {
   dir2 = dir2 *-1;}
   value2 += dir2;
}

void fadeChannel2(){
if (value3 >= 127 || value3 <=0) {
   dir3 = dir3 *-1;}
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