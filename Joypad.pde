/*classe per il joypad dei comandi*/
public static class Joypad
{
  private static int toolButton, incVelocita, decVelocita, cambioAsse, resetCamera;
  private static float analogBraccio[], analogCamera[];
  private static int cambioAssePrec, resetCameraPrec, decVelocitaPrec, incVelocitaPrec, toolButtonPrec; 

  public static void Init()
  {
    analogBraccio = new float[2];
    analogCamera = new float[2];
  }

  public static void GetData(Arduino ardu)
  {
    analogBraccio[0] = ardu.analogRead(PIN_ANALOG_BRACCIO[0]); //dati dell'analogico che controlla il braccio
    analogBraccio[1] = ardu.analogRead(PIN_ANALOG_BRACCIO[1]);

    analogCamera[0] = ardu.analogRead(PIN_ANALOG_CAMERA[0]);
    analogCamera[1] = ardu.analogRead(PIN_ANALOG_CAMERA[1]);

    analogBraccio[0] = map(analogBraccio[0], 0.0, 1023.0, -VALUE_MAP_ROBOT, VALUE_MAP_ROBOT); //condizionamento dati raccolti
    analogBraccio[1] = map(analogBraccio[1], 0.0, 1023.0, -VALUE_MAP_ROBOT, VALUE_MAP_ROBOT);

    analogCamera[0] = map(analogCamera[0], 0.0, 1023.0, -VALUE_MAP_ZOOM, VALUE_MAP_ZOOM);
    analogCamera[1] = map(analogCamera[1], 0.0, 1023.0, -VALUE_MAP_CAMERA, VALUE_MAP_CAMERA);

    if (-VALUE_MAP_ROBOT /4 < analogBraccio[0] && analogBraccio[0] < VALUE_MAP_ROBOT /4)
      analogBraccio[0] = 0.0;
    
    if (-VALUE_MAP_ROBOT /4 < analogBraccio[1] && analogBraccio[1] < VALUE_MAP_ROBOT /4)
      analogBraccio[1] = 0.0;

    if (-VALUE_MAP_ZOOM /4 < analogCamera[0] && analogCamera[0] < VALUE_MAP_ZOOM /4)
      analogCamera[0] = 0.0;
      
    if (-VALUE_MAP_CAMERA /4 < analogCamera[1] && analogCamera[1] < VALUE_MAP_CAMERA /4)
      analogCamera[1] = 0.0;

    //dati dei pulsanti
    cambioAssePrec = cambioAsse;
    cambioAsse = ardu.digitalRead(PIN_BUTTON_CHANGE_AXIS);

    resetCameraPrec = resetCamera;
    resetCamera = ardu.digitalRead(PIN_BUTTON_RESET_CAMERA);

    incVelocitaPrec = incVelocita;
    incVelocita = ardu.digitalRead(PIN_BUTTON_INC_VELOCITA);

    decVelocitaPrec = decVelocita;
    decVelocita = ardu.digitalRead(PIN_BUTTON_DEC_VELOCITA);
    
    toolButtonPrec = toolButton;
    toolButton = ardu.digitalRead(PIN_BUTTON_TOOL);
  }

  public static float[] GetAnalogRobot()
  {
    return analogBraccio;
  }

  public static float[] GetAnalogCamera()
  {
    return analogCamera;
  }

  public static boolean GetChangeButtonValue()
  {
    return cambioAsse == Arduino.LOW && cambioAssePrec == Arduino.HIGH ? true : false;
  }

  public static boolean GetResetCameraValue()
  {
    return resetCamera == Arduino.LOW && resetCameraPrec == Arduino.HIGH ? true : false;
  }

  public static boolean GetIncVelocityValue()
  {
    return incVelocita == Arduino.LOW && incVelocitaPrec == Arduino.HIGH ? true : false;
  }

  public static boolean GetDecVelocityValue()
  {
    return decVelocita == Arduino.LOW && decVelocitaPrec == Arduino.HIGH ? true : false;
  }
  
  public static boolean GetToolValue()
  {
    return toolButton == Arduino.LOW && toolButtonPrec == Arduino.HIGH ? true : false;
  }
}
