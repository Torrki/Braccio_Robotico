//costanti di ambiente
final int WIN_WIDTH = 800;
final int WIN_HEIGHT = 800;
final int SPACE_WIDE = 300;
final static float VALUE_MAP_ROBOT = 5.0;
final static float VALUE_MAP_CAMERA = 2.0;
final static float VALUE_MAP_ZOOM = 7.0;  
final static int LIMIT_ZOOM = 520;

//costanti braccio
final color BACKGROUND_COLOR = color(192);
final color AXIS_COLOR = color(255, 120, 0);
final color JUNCTION_COLOR = color(255, 80, 0);
final int DEFAULT_AXIS_HEIGHT = 70;
final int DEFAULT_AXIS_WIDTH = 20;
final int DEFAULT_JUNCTION_WIDE = 23;
final int OFFSET = 6;
final int OFFSET_JUNCTION = (DEFAULT_AXIS_WIDTH + DEFAULT_JUNCTION_WIDE) /2;
final int BASE_TOOL_HEIGHT = 10;
final int BASE_TOOL_WIDTH = 25;
final int ARM_TOOL_WIDTH = 5;
final float DELTA_CLOSE_TOOL = 14.0;

//costanti Arduino
final static byte PIN_ANALOG_BRACCIO[] = {0, 1};
final static byte PIN_ANALOG_CAMERA[] = {2, 3};
final static byte PIN_BUTTON_TOOL = 2;
final static byte PIN_BUTTON_INC_VELOCITA = 4;
final static byte PIN_BUTTON_DEC_VELOCITA = 7;
final static byte PIN_BUTTON_CHANGE_AXIS = 8;
final static int PIN_BUTTON_RESET_CAMERA = 9;
