import 'dart:html';
import 'dart:async';
import 'dart:convert';


void main()
{
  HttpRequest.getString("levels.json").then((s)   //anon func with s as param on http success
  {
    var levels = JSON.decode(s);
    var gameController = new GameController(levels);
    gameController.loadLevel(0);
  }).catchError((e)
  {
      print(e);
  });

}

class GameController
{
  List levels = [];
  Map currentLevel = {};
  var boardView = null;
  var boardModel = null;


  GameController(var levels)
  {
    this.levels = levels;
    print(levels);
  }

  loadLevel(var level)
  {
    Map currentLevel = levels[level];
    this.currentLevel = currentLevel;
    this.boardModel = new BoardModel(currentLevel["level"], currentLevel["boardSize"],currentLevel["colors"], currentLevel["board"]);
    this.boardView = new BoardView(boardModel.x,boardModel.y,boardModel.colors);
    initButtons();
    updateColors();
  }

  initButtons()
  {
    for(var colorButton in boardView.buttonBar.children)
    {
      var color = colorButton.style.backgroundColor;
      colorButton.onClick.listen((e)
      {
        boardModel.setColor(color);
        updateColors();
        if(boardModel.checkWin())
        {
          boardView.statusBar.innerHtml = "You win!";
        }
      });
    }
  }
  updateColors()
  {
    for(var i = 0; i < boardModel.tiles.length; i++)
    {
      for(var j = 0; j < boardModel.tiles[i].length; j++)
      {
        var color = boardModel.tiles[i][j];
        boardView.boardElem.children[i].children[j].style.backgroundColor = color;
      }
    }
  }
}

class BoardModel
{
  var x,y;
  var colors = [];
  var tiles = [];
  var level = 0;

  BoardModel(var level, var size,var colors, var initialTiles)
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
    for(var i = 0; i < tiles.length; i++)
    {
      for(var j = 0; j < tiles[i].length; j++)
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

class BoardView
{
  var tileViews;
  var rootElem = null;
  var boardElem = null;
  var width = 50.0;
  var height = 50.0;
  var buttonBar = null;
  var titleBar = null;
  var statusBar = null;
  var x = 0;
  var y = 0;
  var colors;

  BoardView(var x , var y, var colors)
  {
    this.x = x;
    this.y = y;
    this.colors = colors;
    init();
  }

  init()
  {
    this.rootElem = querySelector('#main');
    rootElem.children.clear();
    rootElem.style.width = "480px";

    this.titleBar = new Element.tag("H1");
    this.titleBar.innerHtml = "";
    rootElem.children.add(titleBar);

    this.width = double.parse(rootElem.style.width.replaceAll("px", ""))/x; // pixel per tile
    this.height = width;
    this.boardElem = new Element.div();
    rootElem.children.add(boardElem);

    for(var rowY = 0; rowY< y;rowY++)
    {
      var rowElem = new Element.div();
      boardElem.children.add(rowElem);
      for (var tileX = 0; tileX < x;tileX++)
      {
        var tileElem = new DivElement();
        rowElem.append(tileElem);
        tileElem.style.display = "inline-block";
        tileElem.style.border = "solid 1px grey";
        tileElem.style.width = (width * 0.95).toString()+"px";
        tileElem.style.height = height.toString()+"px";
      }
    }

    this.buttonBar = new Element.div();
    this.buttonBar.classes.add("buttonBar");
    rootElem.children.add(buttonBar);
    for(var color in this.colors)
    {
      var colorButton = new ButtonElement();
      colorButton.classes.add("colorButton");
      buttonBar.children.add(colorButton);
      colorButton.style.backgroundColor= color;
      colorButton.style.width =(width * 0.95).toString()+"px";
      colorButton.style.height= height.toString()+"px";

    }
    this.statusBar = new Element.div();
    rootElem.children.add(this.statusBar);
  }
}