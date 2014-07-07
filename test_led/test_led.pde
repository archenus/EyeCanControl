import processing.serial.*;
Serial port;

boolean button = false;

int x = 150;
int y = 150;
int w = 100;
int h = 75;

void setup()
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

void draw()
{
  if(button)
  {
    background(255);
    stroke(0);
  }
  else
  {
    background(0);
    stroke(255);
  }
  
  fill(175);
  rect(x, y, w, h);
}

void mousePressed()
{
  if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
  {
    button = !button;
  }
  
  if(button == true)
  {
    port.write(11); // Led On
  }
  else
  {
    port.write(10); // Led Off
  }
}

