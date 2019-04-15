//variable maps test one

float scalar;
import processing.serial.*;

Serial myPort;
int knobState;
int pressureState;
int[] inputVars = {0, 0}; //make array to be populated from serial (note number of variables)

float x;
float y;
float easing = 0.05;

void setup () {
  size(640, 360);
  rectMode(CENTER);
  println(Serial.list()); //print serial devices (remember to count from 0)
  myPort = new Serial(this, Serial.list()[1], 9600); //make sure the baudrate matches arduino
  myPort.bufferUntil('\n'); // don't generate a serialEvent() unless you get a newline character
}

void draw () {
  background(255,228,196);
  // scale(map(inputVars[0], 0, 1023, 1, 4));
   // Scale the mouseX value from 0 to 640 to a range between 0 and 175
  float c = map(inputVars[1], 0, width, 0, 175);
  scalar = map(inputVars[0], 0, 1023, 1, 3);
  // Scale the mouseX value from 0 to 640 to a range between 40 and 300
  float d = map(inputVars[0], 0, width, 40, 300);
  fill(205, c, 10);
  
  //push();
  //scale(map(inputVars[1], 0, 1023, 1, 4));
  translate(width/2,height/2);
  ellipse(0*scalar, 0*scalar, 40*scalar, 40*scalar);
  //eyes
  fill(205,133,63);
  ellipse(-6*scalar,0,9*scalar,9*scalar);
  fill(255);
  ellipse(-6*scalar,0*scalar,5*scalar,5*scalar);
  fill(205,133,63);
  ellipse(6*scalar,0*scalar,9*scalar,9*scalar);
   fill(255);
  ellipse(6*scalar,0*scalar,5*scalar,5*scalar);
  //nose
   fill(  0,0,0);
  ellipse(0*scalar,6*scalar,5*scalar,5*scalar);
  //mouth
  fill(255);
  ellipse(0,5,9,5);
  //line(0,5, 0, 12);
 
  //pop(); 
  float targetX = inputVars[1];
  float dx = targetX - x;
  x += dx * easing;
  
  float targetY =inputVars[1];
  float dy = targetY - y;
  y += dy * easing;
 fill(0,0,0);
  ellipse(x, y, 66, 66);
  

}

  //if (inputVars[1] > 500){
  //  fill(color(int(random(255)),int(random(255)),int(random(255))));
  //}
  //else{
  //  fill(255);
  //}
  //rect(width/2, height/2, map(inputVars[0], 0, 1023, 0, width), map(inputVars[0], 0, 1023, 0, width));

//scale(-5.5);
//ellipse(0,0,100,140);



void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n'); //read until new line (Serial.println on Arduino)
  if (inString != null) {
    inString = trim(inString); // trim off whitespace
    inputVars = int(split(inString, '&')); // break string into an array and change strings to ints 
}
}
