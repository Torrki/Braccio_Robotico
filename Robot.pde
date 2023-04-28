/*classe per il braccio robotico*/
public class Robot implements IDrawable
{
  private int start_x, start_y, start_z;
  private class Asse implements IDrawable
  {
    int width, height;
    PShape shape;
    public Asse(int _width, int _height)
    {
      this.width = _width;
      this.height = _height;
      this.shape = createShape(BOX, this.width, this.height, this.width);
    }

    public void Draw()
    {
      push();
      fill(AXIS_COLOR);
      strokeWeight(0.5);
      box(this.width, this.height, this.width);
      pop();
    }
  }

  //classe giunzione
  protected abstract class Giunzione implements IDrawable
  {
    int wide;
    float angolo;
    PShape shape;

    public void Draw()
    {
      push();
      fill(JUNCTION_COLOR);
      strokeWeight(0.5);
      shape(this.shape);
      pop();
    }

    public abstract void SetAngle(float angInRadians);
    public abstract float GetAngle();
    public abstract void Rotate();
  }
  //classe figlia per la giunzione che ruota sull'asse x
  public class GiunzioneX extends Giunzione
  {

    public GiunzioneX(int wide)
    {
      this.wide = wide;
      this.angolo = 0.0;

      this.shape = createShape(BOX, this.wide);
    }

    @Override
      public void SetAngle(float angInRadians)
    {
      this.angolo = angInRadians;
    }

    @Override
      public float GetAngle()
    {
      return this.angolo;
    }

    @Override
      public void Rotate()
    {
      rotateX(this.angolo);
    }
  }

  //classe figlia per la giunzione che ruota sull'asse y
  public class GiunzioneY extends Giunzione
  {
    public GiunzioneY(int wide)
    {
      this.wide = wide;
      this.angolo = 0.0;

      this.shape = createShape(BOX, this.wide);
    }

    @Override
      public void SetAngle(float angInRadians)
    {
      this.angolo = angInRadians;
    }

    @Override
      public float GetAngle()
    {
      return this.angolo;
    }

    @Override
      public void Rotate()
    {
      rotateY(this.angolo);
    }
  }

  private Asse assiRobot[];
  private Giunzione giunzioniRobot[];
  private Tool pinza;
  private byte currentAxis;
  private float velocity;
  public Robot(int x, int y, int z)
  {
    //memorizzo le coordinate iniziali
    this.start_x = x;
    this.start_y = y;
    this.start_z = z;

    this.currentAxis = 0;
    this.velocity = 1.0f;

    //inizializzo gli assi
    assiRobot = new Asse[4];
    assiRobot[0] = new Asse(DEFAULT_AXIS_WIDTH, DEFAULT_AXIS_HEIGHT);
    assiRobot[1] = new Asse(DEFAULT_AXIS_WIDTH, DEFAULT_AXIS_HEIGHT);
    assiRobot[2] = new Asse(DEFAULT_AXIS_WIDTH, DEFAULT_AXIS_HEIGHT);
    assiRobot[3] = new Asse(DEFAULT_AXIS_WIDTH -5, DEFAULT_AXIS_HEIGHT);

    //inizializzo le giunzioni
    giunzioniRobot = new Giunzione[4];
    giunzioniRobot[0] = new GiunzioneX(DEFAULT_JUNCTION_WIDE);
    giunzioniRobot[1] = new GiunzioneX(DEFAULT_JUNCTION_WIDE);
    giunzioniRobot[2] = new GiunzioneX(DEFAULT_JUNCTION_WIDE);
    giunzioniRobot[3] = new GiunzioneY(DEFAULT_JUNCTION_WIDE);

    //inizializzo la pinza
    pinza = new Tool(30);
  }

  public void Draw()
  {
    pushMatrix();
    translate(this.start_x, this.start_y, this.start_z);  //mi posiziono sulle coordinate iniziali
    drawChart3D(80);
    assiRobot[0].Draw(); //disegno il primo                   

    translate(-(DEFAULT_AXIS_WIDTH + DEFAULT_JUNCTION_WIDE)/2, -(DEFAULT_AXIS_HEIGHT - DEFAULT_AXIS_WIDTH) /2, 0);      
    giunzioniRobot[0].Rotate();
    drawChart3D(80);
    giunzioniRobot[0].Draw(); //disegno la prima giunzione

    translate(0, -(DEFAULT_AXIS_HEIGHT + DEFAULT_JUNCTION_WIDE) /2, 0);
    assiRobot[1].Draw(); //disegno il secondo asse

    translate((DEFAULT_AXIS_WIDTH + DEFAULT_JUNCTION_WIDE)/2, -(DEFAULT_AXIS_HEIGHT - DEFAULT_AXIS_WIDTH) /2, 0);
    giunzioniRobot[1].Rotate();
    drawChart3D(80);
    giunzioniRobot[1].Draw(); //disegno la seconda giunzione

    translate(0, -(DEFAULT_AXIS_HEIGHT + DEFAULT_JUNCTION_WIDE) /2, 0);
    assiRobot[2].Draw(); //disegno il terzo asse

    translate(0, -(DEFAULT_AXIS_HEIGHT + DEFAULT_JUNCTION_WIDE) /2, 0);
    giunzioniRobot[2].Draw(); //disegno la terza giunzione

    translate(-DEFAULT_JUNCTION_WIDE, 0, 0);
    drawChart3D(80);
    giunzioniRobot[2].Rotate();
    giunzioniRobot[3].Draw(); //disegno la quarta giunzione

    translate(0, -(DEFAULT_AXIS_HEIGHT + DEFAULT_JUNCTION_WIDE) /2, 0);
    giunzioniRobot[3].Rotate();
    assiRobot[3].Draw(); //disegno il quarto asse

    //disegno la pinza
    translate(0, -(DEFAULT_AXIS_HEIGHT + BASE_TOOL_HEIGHT) /2, 0);
    pinza.Draw();
    popMatrix();
  }

  public void Update()
  {
    //comando analogici
    float valuesRobot[] = Joypad.GetAnalogRobot();
    if (giunzioniRobot[currentAxis].getClass() == GiunzioneX.class)
    {
      valuesRobot[0] = giunzioniRobot[currentAxis].GetAngle() + (radians(valuesRobot[0] * this.velocity));
      giunzioniRobot[currentAxis].SetAngle(valuesRobot[0]);
    } else
    {
      valuesRobot[1] = giunzioniRobot[currentAxis].GetAngle() + (radians(valuesRobot[1] * this.velocity));
      giunzioniRobot[currentAxis].SetAngle(valuesRobot[1]);
    }

    //comandi digitali
    if (Joypad.GetChangeButtonValue())
    {
      if (currentAxis == giunzioniRobot.length - 1)
        currentAxis = 0;
      else
        currentAxis++;
    }
    
    if(Joypad.GetToolValue())
      pinza.toolOpen = !pinza.toolOpen;
      
    //comando velocità
    if (Joypad.GetDecVelocityValue() && this.velocity > 0.0)
      this.velocity -= 0.1;
    else if (Joypad.GetIncVelocityValue() && this.velocity < 1.0)
      this.velocity += 0.1;

    //movimento pinza
    pinza.Move();
  }
  
  public float GetVelocity()
  {
    return this.velocity;
  }
}
