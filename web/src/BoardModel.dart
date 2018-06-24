part of main;
/* The Model class:
    Implements the game model and instantiation for each level
    with the following parameters
    level: the level as an integer value
    size: the size of the Game Board as an integer value
    colors: the colors present in an instance as a list of strings
    initialTiles: the initial tiles of the Board as a list of lists of (background)colors
    maxSteps: the maximum steps allowed for each level as an integer
*/
class BoardModel
{
  var x,y;
  var colors = [];
  var tiles = [];
  var level = 0;
  var maxSteps = 0;
  var score = 0;

  BoardModel(var level, var size, var colors, var initialTiles, var maxSteps)
  {
    this.level = level;
    this.x = size;
    this.y = size;
    this.colors = colors;
    tiles = initialTiles;
    this.maxSteps = maxSteps;
  }

  setColor(var newColor) // set the old color tiles to the new color
  {
    var oldColor = tiles[0][0];
    for(var i = 0; i < tiles.length; i++)
    {
      for(var j = 0; j < tiles[i].length; j++)
      {
        if(tiles[i][j] == oldColor)
        {
          tiles[i][j] = newColor;
          score +=2;
        }
        else
        {
          break;       // if tile is not of old color skip it
        }
      }
    }
  }
  checkWin()    // check whether the entire board consists of the same color
  {
    var color = tiles[0][0];
    for(var i = 0; i <tiles.length; i++)
    {
      for(var j = 0; j < tiles[i].length; j++)
      {
        if(tiles[i][j] != color)
        {
          return false;
        }
      }
    }
    return true;
  }
}