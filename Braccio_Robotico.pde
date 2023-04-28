import cc.arduino.*;
import org.firmata.*;

import processing.serial.*;

void settings()
{
  size(WIN_WIDTH, WIN_HEIGHT, P3D);
}

Arduino arduinoUno;
Ambiente spazio;
Robot BraccioRobotico;
void setup()
{
  spazio = new Ambiente(SPACE_WIDE, "./textures/Pavimento_Legno.jpg");
  BraccioRobotico = new Robot(0, -DEFAULT_AXIS_HEIGHT /2, 0);
  Joypad.Init();
  arduinoUno = new Arduino(this, Arduino.list()[0], 57600);
  arduinoUno.pinMode(PIN_BUTTON_CHANGE_AXIS, Arduino.INPUT_PULLUP);
  arduinoUno.pinMode(PIN_BUTTON_RESET_CAMERA, Arduino.INPUT_PULLUP);
  arduinoUno.pinMode(PIN_BUTTON_INC_VELOCITA, Arduino.INPUT_PULLUP);
  arduinoUno.pinMode(PIN_BUTTON_DEC_VELOCITA, Arduino.INPUT_PULLUP);
  arduinoUno.pinMode(PIN_BUTTON_TOOL, Arduino.INPUT_PULLUP);
}

void draw()
{
  background(BACKGROUND_COLOR);

  //disegno gli assi cartesiani per orientarmi
  drawChart3D(200);

  //disegno il pavimento
  pushMatrix();
  translate(0, OFFSET, 0);
  strokeWeight(0.5);
  spazio.Draw();
  popMatrix();

  //prendo i dati
  Joypad.GetData(arduinoUno);
  //aggiorno il robot e la camera
  spazio.UpdateCamera();
  BraccioRobotico.Update();  
  //disegno il braccio
  BraccioRobotico.Draw();
}

void drawChart3D(int dim)
{
  push();
  strokeWeight(1);
  stroke(255, 0, 0);
  line(-dim, 0, 0, dim, 0, 0); //x
  stroke(0, 255, 0);
  line(0, -dim, 0, 0, dim, 0); //y
  stroke(0, 0, 255);
  line(0, 0, -dim, 0, 0, dim); //z
  pop();
}
