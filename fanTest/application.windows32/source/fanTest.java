import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class fanTest extends PApplet {


Serial port;

boolean button = false;
boolean button2 = false;

int x = 80;
int y = 120;
int w = 100;
int h = 75;


int x2 = 250;
int y2 = 120;
int w2 = 100;
int h2 = 75;

int data;

public void setup()
{
  // Set up the port
  
  String XBeePort = Serial.list()[0];
  
  // Set Baud Rate to 9600 bps
  port = new Serial(this, XBeePort, 9600);
  
  // Setup the screen for output
  size(400, 400);
  
  
  // Debug
  println("Port Test");
  println("Available serial port: ");
  println(Serial.list());
  // arduino serial port = 0
  port.write(100);
  
}

public void draw()
{
  if(button)
  {
    button2 = false;
    background(255);
    stroke(0);
    //println("low");
    
  }
  else if(button2)
  {
    button = false;
    background(204);
    stroke(0);
    //println("high");
   // println("=======");
  }
  else 
  {
    background(0);
    stroke(255);
    //println("Off");
    //println("=======");
  }
  /*
  
  else
  {
    background(150);
    stroke(150);
    println("Off2");
  }
  
  */
  fill(175);
  rect(x, y, w, h);
  
  fill(200);
  rect(x2, y2, w2, h2);

}

public void mousePressed()
{
  if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
  {
    button = !button;
  }
  if(mouseX > x2 && mouseX < x2+w2 && mouseY > y2 && mouseY < y2+h2)
  {
    button2 = !button2;
  }

 
  if(button == true)
  {
    port.write(21); // pan low 
    println("low");
  }
  else if(button2 == true) 
  {
    port.write(22); // pan high
    println("high");
  }
  else
  {
    port.write(20); // pan off
    println("off");
  }

}
public void loop()
{
  data = port.read();
  println(data);
}

static public void main(String args[]) 
{
    PApplet.main("fanTest");
}
}
