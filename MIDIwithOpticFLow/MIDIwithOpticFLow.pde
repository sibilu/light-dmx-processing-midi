import themidibus.*; //Import the library
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

OpenCV opencv;
Capture video;
float vMidiX; //value at x axis
float vMidiY; //value at y axis
int toCue;//will send a signal from 0-127 to Cuelux

MidiBus myBus; // The MidiBus
int midiChannel = 1;
int midiChannel2 = 2; //karo
int value = 64;
int valueY = 64;
int someVar = 0;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);  
 // opencv.loadCascade(OpenCV.CASCADE_EYE); 
  video.start();
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, "loopMIDI Port"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  background(0);
  opencv.loadImage(video);
  opencv.calculateOpticalFlow();

  image(video, 0, 0);
  translate(video.width,0);
  stroke(255,0,0);
  opencv.drawOpticalFlow();
  
  PVector aveFlow = opencv.getAverageFlow();
  int flowScale = 50;
  

  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(2);
  line(video.width/2, video.height/2, video.width/2 + aveFlow.x*flowScale, video.height/2 + aveFlow.y*flowScale);
  vMidiX = aveFlow.x*flowScale;
  vMidiY = aveFlow.y*flowScale;

  //println("x axis: ", vMidiX);
  //println("y axis: ", vMidiY);
  
  //if you go left the value channel go up
  if(vMidiX > 30){
   value+=10;
  }
  if(vMidiX < -30){
   value-=10; 
  }

  if(vMidiY < 10){ //if sth moves up (y axis) than channel2 goes up
   valueY+=3;
  }
  if(vMidiY > -10){ //if something moves down (on y axis) than channel2 goes down
   valueY-=3; 
  }
  println(value);
  //value++;
  myBus.sendControllerChange(someVar, midiChannel, value); // Send a controllerChange
  //channel2
  myBus.sendControllerChange(someVar, midiChannel2, valueY); // Send a controllerChange


  delay(100);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
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

void captureEvent(Capture c) {
  c.read();
}