import 'dart:html';

void main()
{
  var board = new Board(4,6);
  var boardView = new BoardView();
  boardView.boardModel = board;
  boardView.init();
}


class Tile
{
  var color;
}
//Eventlistener hinzufügen, event muss ausgelöst werden, wenn das board oder ein Tile verändert wird
//im eventlistener muss das board neu gerendert werden.
class Board
{
  var x,y;
  var tiles = new List();
  Board(var x,var y)
  {
    this.x = x;
    this.y = y;
    for(var i = 0; i < x; i++)
    {
      var list = new List();
      tiles.add(list);
      for(var j = 0; j < y;j++)
      {
        list.add(new Tile());
      }
    }
  }
}

class BoardView
{
  var boardModel;
  var tileViews;
  // list
  // for, for - which tile zu welchem button/farbe(backgroundcolor)
  // on board view update render
  render()
  {}


  init()
  {
    var rootTag = querySelector('#main');

    for(var row in boardModel.tiles)
    {
      var rowElem = new Element.div();
      rootTag.append(rowElem);
      for (var tile in row)
      {
        var button = new ButtonElement();
        button.text = "A";
        rowElem.append(button);
        button.onClick.listen((e){button.text = "B"; tile.color = "#ff0000";});
      }
    }
  }
}