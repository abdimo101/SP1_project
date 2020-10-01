import java.util.Random;

class Game
{

  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private int player2Life;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] foods;
  private int maxLife = 100;
  private int max2Life = 100;
  private boolean gameOver = false;
  Game(int width, int height, int numberOfEnemies, int numberOfFoods)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(24, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    foods = new Dot[numberOfFoods];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for (int i = 0; i < numberOfFoods; ++i)
    {
      foods[i] = new Dot((int)random(0, 25), (int)random(0, 25), (int)random(0, 25), (int)random(0, 25));
    }
    this.playerLife = maxLife;
    this.player2Life = max2Life;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }

  public int getPlayer2Life()
  {
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }


  public void onKeyPressed2(char key_)
  {
    keys.onKeyPressed2(key_);
  }

  public void onKeyReleased2(char key_)
  {
    keys.onKeyReleased2(key_);
  }

  public void update()
  {
    if (gameOver != true) {
      updatePlayer();
      updatePlayer2();
      updateEnemies();
      checkForCollisions();
      clearBoard();
      populateBoard();
      updateFood();
    } else {
      if (player2Life > playerLife) {
        
        println("Player 2 Wins!!!");
        noLoop();
      } else {
        
        println("Player 1 Wins!!!");
        noLoop();
      }
    }
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }


  private void updatePlayer2()
  {
    //Update player2
    if (keys.arrowUp() && !keys.arrowDown())
    {
      player2.moveUp();
    }
    if (keys.arrowLeft() && !keys.arrowRight())
    {
      player2.moveLeft();
    }
    if (keys.arrowDown() && !keys.arrowUp())
    {
      player2.moveDown();
    }
    if (keys.arrowRight() && !keys.arrowLeft())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int dx2 = player2.getX() -enemies[i].getX();
        int dy2 = player2.getY() - enemies[i].getY();
        if (dx + dy > dx2 + dy2) {
          dx = dx2;
          dy = dy2;
        }
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1; // '1' is refering to color blue in main class
    //Insert player2
    board[player2.getX()][player2.getY()] = 4; // '4' is refering to color cyan in main class
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2; // '2' is refering to color red in main class
    }
    //insert food
    for (int i = 0; i < foods.length; ++i)
    { 
      board[foods[i].getX()][foods[i].getY()] = 3; // '3' is refering to color green in main class
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
        if (playerLife < 1) {
          gameOver = true;
        }
      }

      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a collision
        --player2Life;
        if (player2Life < 1) {
          gameOver = true;
        }
      }
    }

    //Check food collisions
    //int foodsLength = foods.length;
    for (int i = 0; i < foods.length; ++i) 
    {
      if (foods[i].getX() == player.getX() && foods[i].getY() == player.getY())
      {
        //We have a collision and playerLife wont be above maxLife(100).
        this.playerLife = playerLife < 99 ? playerLife + 1 : maxLife;
        //food disappears and reappears again on a different location.
        foods[i].x =int(random(foods[i].maxX));
        foods[i].y= int(random(foods[i].maxY));
      } else if (foods[i].getX() == player2.getX() && foods[i].getY() == player2.getY()) {
        //We have a collision and playerLife wont be above maxLife(100).
        this.player2Life = player2Life < 99 ? player2Life + 1 : max2Life;
        //food disappears and reappears again on a different location.
        foods[i].x =int(random(foods[i].maxX));
        foods[i].y= int(random(foods[i].maxY));
      }
    }
  }
  // this is a duplicate of updateEnemy.
  private void updateFood() {
    for (int i = 0; i < foods.length; i++)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(2) < 1)
      {
        //We dont follow, we do the opposite, therefore instead of minus, we put plus between the distance of the foods and the player. 
        int dx = player.getX() + foods[i].getX();
        int dy = player.getY() + foods[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx < 0)
          {
            //Player is to the right
            foods[i].moveRight();
          } else
          {
            //Player is to the left
            foods[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          foods[i].moveDown();
        } else
        {//Player is up;
          foods[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          foods[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          foods[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          foods[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          foods[i].moveDown();
        }
      }
    }
  }
}
