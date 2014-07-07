import processing.serial.*;
Serial port;

boolean btn_fan_low = false;
boolean btn_fan_high = false;
boolean btn_led = false;

int x = 80;
int y = 120;
int w = 100;
int h = 75;


int x2 = 250;
int y2 = 120;
int w2 = 100;
int h2 = 75;

int x3 = 80;
int y3 = 200;
int w3 = 100;
int h3 = 75;

int data;
boolean isFan = false;
boolean isLed = false;


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
  if(btn_fan_low) // fan low
  {
    btn_fan_high = false;
    background(255);
    stroke(0);
    //println("low");
    
  }
  else if(btn_fan_high) // fan high
  {
    btn_fan_low = false;
    background(204);
    stroke(0);
    //println("high");
  }
  else if(btn_led) // led on
  {
    background(170);
    stroke(0);
  }
  else // fan off
  {
    background(0);
    stroke(255);
    //println("Off");
  }
  
  fill(175);
  rect(x, y, w, h);
  
  fill(200);
  rect(x2, y2, w2, h2);

  fill(250);
  rect(x3, y3, w3, h3);
}

void mousePressed()
{
  if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
  {
    btn_fan_low = !btn_fan_low;
    isFan = true;
    isLed = false;
  }
  if(mouseX > x2 && mouseX < x2+w2 && mouseY > y2 && mouseY < y2+h2)
  {
    btn_fan_high = !btn_fan_high;
    isFan = true;
    isLed = false;
  }
  if(mouseX > x3 && mouseX < x3+w3 && mouseY > y3 && mouseY < y3+h3)
  {
    btn_led = !btn_led;
    isLed = true;
    isFan = false;
  }

  if(isFan) // 선풍 
  {
      if(btn_fan_low == true)
      {
        port.write(21); // pan low 
        println("low");
      }
      else if(btn_fan_high == true) 
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
  else if(isLed) // 전등 
  {
      if(btn_led == true)
      {
        port.write(11);
        println("led on"); 
      }
      else
      {
        port.write(10);
        println("led off"); 
      }
  }

}
void loop()
{
  data = port.read();
  println(data);
}


