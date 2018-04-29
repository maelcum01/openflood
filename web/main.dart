import 'dart:html';

void main()
{
  var board = new Board(4,6);
  var boardView = new BoardView();
  boardView.boardModel = board;
  boardView.render();
}


class Tile
{
  var color;
}

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
      var list= new List();
      tiles.add(list);
      for(var j 0; j < y;j++)
      {
          list.add(new Tile());

      }
    }

  }
}

class BoardView
{
  var boardModel;

  render()
  {
    var rootTag = querySelector('#main');

    for(var row in boardModel.tiles)
    {
      var rowElem = Element.div();
      rootTag.append(rowElem);
      for (var tile in row)
      {

        var button = new ButtonElement();
        button.text = "A";
        rowElem.append(button);


      }
    }
  }

}