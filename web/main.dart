import 'dart:html';
import 'dart:async';
import 'dart:convert';




void main()
{
  HttpRequest.getString("/levels.json").then((s) {
     //anon func with s as param on http success
    List levels = JSON.decode(s);

    var gameController = new GameController(levels);
    gameController.loadLevel(0);
    }).catchError((e) {
      print(e);
  });

}

class GameController
{
  List levels = [];
  Map currentLevel = null;

  GameController(var levels)
  {
    this.levels = levels;
    print(levels);
  }


  loadLevel(var level)
  {
    Map currentLevel = levels[level];
    this.currentLevel = currentLevel;
    var board = new Board(currentLevel["level"], currentLevel["boardSize"],currentLevel["colors"], currentLevel["board"]);

    var boardView = new BoardView();
    boardView.boardModel = board;
    boardView.init();
  }

}

//Eventlistener hinzufügen, event muss ausgelöst werden, wenn das board oder ein Tile verändert wird
//im eventlistener muss das board neu gerendert werden.
class Board
{
  var x,y;
  var colors = [];
  var tiles = [];
  var level = 0;

  Board(var level, var size,var colors, var initialTiles)
  {
    this.level = level;
    this.x = size;
    this.y = size;
    this.colors = colors;
    tiles = initialTiles;
  }

  setColor(var newColor)
  {
    var oldColor = tiles[0][0];
    for(var i = 0; i<tiles.length;i++)
    {
      for(var j = 0; j< tiles[i].length;j++)
      {
        if(tiles[i][j] == oldColor)
        {
          tiles[i][j] = newColor;
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
    for(var i = 0; i<tiles.length;i++)
    {
      for(var j = 0; j< tiles[i].length;j++)
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

class BoardView
{
  var boardModel;
  var tileViews;
  var rootElem = null;
  var boardElem = null;
  var width = 50.0;
  var height = 50.0;
  var buttonBar = null;
  var titleBar = null;
  var statusBar = null;
  // list
  // for, for - which tile zu welchem button/farbe(backgroundcolor)
  // on board view update render

  init()
  {
    this.rootElem = querySelector('#main');
    rootElem.children.clear();
    rootElem.style.width = "480px";

    this.titleBar = new Element.tag("H1");
    this.titleBar.innerHtml = "Level " + boardModel.level.toString();
    rootElem.children.add(titleBar);

    this.width = double.parse(rootElem.style.width.replaceAll("px", ""))/boardModel.x;
    this.height = width;
    this.boardElem = new Element.div();
    rootElem.children.add(boardElem);

    for(List row in boardModel.tiles)
    {
      var rowElem = new Element.div();
      boardElem.children.add(rowElem);
      for (var tileColor in row)
      {
        var tileElem = new DivElement();
        rowElem.append(tileElem);
        tileElem.style.display = "inline-block";
        tileElem.style.backgroundColor = tileColor;
        tileElem.style.border = "solid 1px grey";

        tileElem.style.width = (width * 0.95).toString()+"px";
        tileElem.style.height = height.toString()+"px";
      }
    }

    this.buttonBar = new Element.div();
    rootElem.children.add(buttonBar);
    for(var color in boardModel.colors)
    {
      var colorButton = new ButtonElement();
      buttonBar.children.add(colorButton);
      colorButton.style.backgroundColor= color;
      colorButton.style.width =(width * 0.95).toString()+"px";
      colorButton.style.height= height.toString()+"px";

      colorButton.onClick.listen((e) {
        boardModel.setColor(color);
        updateColors();
        if(boardModel.checkWin()) {
          statusBar.innerHtml = "You won!";
        }
      });
    }

    this.statusBar = new Element.div();
    rootElem.children.add(this.statusBar);

  }

  updateColors()
  {
    for(var i=0;i<boardModel.tiles.length;i++) {
      for(var j=0;j<boardModel.tiles[i].length;j++) {
        var color = boardModel.tiles[i][j];
        boardElem.children[i].children[j].style.backgroundColor = color;
      }
    }
  }
}