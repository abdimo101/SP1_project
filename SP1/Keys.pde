class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  
  private boolean arrowUp = false;
  private boolean arrowLeft = false;
  private boolean arrowRight = false;
  private boolean arrowDown = false;
  
  public Keys(){}
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  
  
  void onKeyPressed(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = true;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = true;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
  }

  void onKeyReleased2(char key_)
  {
    if(key_ == CODED){
    if(keyCode == UP)
    {
      arrowUp = false;
    }
    else if (keyCode == LEFT)
    {
      arrowLeft = false;
    }
    else if(keyCode == DOWN)
    {
      arrowDown = false;
    }
    else if(keyCode == RIGHT)
    {
      arrowRight = false;
    }
    }
    
  }
  
  

  
  public boolean arrowUp()
  {
    return arrowUp;
  }
  
  public boolean arrowLeft()
  {
    return arrowLeft;
  }
  
  public boolean arrowDown()
  {
    return arrowDown;
  }
  
  public boolean arrowRight()
  {
    return arrowRight;
  }
  
  
  
  void onKeyPressed2(char key_)
  {
    if(key_ == CODED){
    if(keyCode == UP)
    {
      arrowUp = true;
    }
    else if (keyCode == LEFT)
    {
      arrowLeft = true;
    }
    else if(keyCode == DOWN)
    {
      arrowDown = true;
    }
    else if(keyCode == RIGHT)
    {
      arrowRight = true;
    }
    }
  }
  
  void onKeyReleased(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = false;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = false;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
  }
  
  
  
}
