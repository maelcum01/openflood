part of 'main.dart';
/* The Model class:
    Implements the game model and instantiation for each level
    with the following parameters

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

  setColor(var newColor)
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
          break;
        }
      }
    }
  }
  checkWin()
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