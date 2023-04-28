/*classe per l'ambiente*/

public class Ambiente implements IDrawable
{
  private PImage img;
  private PShape box;
  private float angCamera;
  private float zoom;
  public Ambiente(int wide, String filename)
  {
    this.box = createShape(BOX, wide, 12, wide);
    this.img = loadImage(filename);

    if (this.img == null)
      exit();
    this.box.setTexture(this.img);
    angCamera = radians(90.0);
    zoom = 0.0;
  }

  //metodo per disegnare
  public void Draw()
  {
    shape(this.box, 0, 0);
  }

  public void UpdateCamera()
  {
    float cameraData[] = Joypad.GetAnalogCamera();  //prendo i dai dal Joypad e li sommo all'angolazione precedente della camera
    this.angCamera += -radians(cameraData[1]);
    this.zoom += cameraData[0];
    
    //se premo il pulsante per il reset della camera
    if(Joypad.GetResetCameraValue())
    {
      this.angCamera = radians(90.0);
      this.zoom = 0.0;
    }

    //aggiorno la posizione della camera
    camera(cos(this.angCamera) * (WIN_WIDTH - zoom), -250.0, sin(this.angCamera) * (WIN_WIDTH - zoom), 0.0, -zoom /2.5, 0.0, 0.0, 1.0, 0.0);
  }
}
