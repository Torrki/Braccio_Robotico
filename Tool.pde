/*classe per il tool sul braccio*/

public class Tool implements IDrawable
{
  public boolean toolOpen;
  private int height;
  private float delta;

  public Tool(int _height)
  {
    this.height = _height;
    this.toolOpen = true;
    this.delta = 0.0;
  }

  public void Move()
  {
    if (this.toolOpen)
    {
      if (delta > 0.0)
        delta -= 2.0 * BraccioRobotico.GetVelocity();
    } else
    {
      if (delta < DELTA_CLOSE_TOOL)
        delta += 2.0 * BraccioRobotico.GetVelocity();
    }
  }

  public void Draw()
  {
    push();
    fill(JUNCTION_COLOR);
    box(BASE_TOOL_WIDTH, BASE_TOOL_HEIGHT, BASE_TOOL_WIDTH); //base pinza

    //pinza    
    translate(0, -(BASE_TOOL_HEIGHT + this.height) /2, 0);
    push();
    translate(-(BASE_TOOL_WIDTH - ARM_TOOL_WIDTH - delta) /2, 0, 0);
    box(ARM_TOOL_WIDTH, this.height, ARM_TOOL_WIDTH);
    pop();

    push();
    translate((BASE_TOOL_WIDTH - ARM_TOOL_WIDTH -delta) /2, 0, 0);
    box(ARM_TOOL_WIDTH, this.height, ARM_TOOL_WIDTH);
    pop();
    pop();
  }
}
