class Controller {
  int note;
  int intensity;
  int dir;
  Controller (int note, int intensity) {
    this.note = note;
    this.intensity = intensity;
      myBus.sendControllerChange(someVar, note, intensity); // Send a controllerChange

  }
  
  void fade (){
  if (this.intensity >= 127 || this.intensity <=0) {
   this.dir = this.dir *-1;}
   this.intensity += this.dir;
  }
}