import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
int midiChannel = 1;
int value = 0;
int someVar = 0;

void setup() {
  size(400, 120);


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
  text("Midi Channel: "+midiChannel, 0, 50); 
  text("Intensity: "+value, 0, 100); 

sendMidi();

}

void sendMidi(){
  //velocity++;
  if (value < 127) {
    value++;
  } 

  myBus.sendControllerChange(someVar, midiChannel, value); // Send a controllerChange

  delay(100);
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