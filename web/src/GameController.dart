part of 'main';

class GameController
{
  List levels = [];
  Map currentLevel = {};
  var boardView = null;
  var boardModel = null;
  var thisLevel = 0;
  var turns = 0;

  Timer delayLoadLevel(var level)
  {
    return new Timer(const Duration(seconds: 5), () => this.loadLevel(level));
  }

  Timer loadGameOver()
  {
    return new Timer(const Duration(seconds: 2), () => this.gameOver());
  }

  GameController(var levels)
  {
    this.levels = levels;
    print(levels);
  }

  loadLevel(var level)
  {
    Map currentLevel = levels[level];
    this.currentLevel = currentLevel;
    this.boardModel = new BoardModel(currentLevel["level"], currentLevel["boardSize"],currentLevel["colors"], currentLevel["board"],currentLevel["maxSteps"]);
    this.boardView = new BoardView(boardModel.x,boardModel.y,boardModel.colors);
    initButtons();
    updateColors();
  }

  gameOver()
  {
    boardView.rootElem.children.clear();
    var asciiArt =  new Element.pre();
    boardView.rootElem.children.add(asciiArt);
    asciiArt.text ="      ▄████  ▄▄▄       ███▄ ▄███▓▓█████  "+"\n"
        +"     ██▒ ▀█▒▒████▄    ▓██▒▀█▀ ██▒▓█   ▀  "+"\n"
        +"    ▒██░▄▄▄░▒██  ▀█▄  ▓██    ▓██░▒███    "+"\n"
        +"    ░▓█  ██▓░██▄▄▄▄██ ▒██    ▒██ ▒▓█  ▄  "+"\n"
        +"    ░▒▓███▀▒ ▓█   ▓██▒▒██▒   ░██▒░▒████▒ "+"\n"
        +"     ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ░  ░░░ ▒░ ░ "+"\n"
        +"      ░   ░   ▒   ▒▒ ░░  ░      ░ ░ ░  ░ "+"\n"
        +"    ░ ░   ░   ░   ▒   ░      ░      ░    "+"\n"
        +"          ░       ░  ░       ░      ░  ░ "+"\n"
        +"                                         "+"\n"
        +"      ▒█████   ██▒   █▓▓█████  ██▀███ "+"\n"
        +"    ▒██▒  ██▒▓██░   █▒▓█   ▀ ▓██ ▒ ██▒"+"\n"
        +"    ▒██░  ██▒ ▓██  █▒░▒███   ▓██ ░▄█ ▒"+"\n"
        +"    ▒██   ██░  ▒██ █░░▒▓█  ▄ ▒██▀▀█▄  "+"\n"
        +"    ░ ████▓▒░   ▒▀█░  ░▒████▒░██▓ ▒██▒"+"\n"
        +"    ░ ▒░▒░▒░    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░"+"\n"
        +"      ░ ▒ ▒░    ░ ░░   ░ ░  ░  ░▒ ░ ▒░"+"\n"
        +"    ░ ░ ░ ▒       ░░     ░     ░░   ░ ░"+"\n"
        +"        ░ ░        ░     ░  ░   ░      ░"+"\n"
        +"                   ░";
  }

  initButtons()
  {
    for(var colorButton in boardView.buttonBar.children)
    {
      var color = colorButton.style.backgroundColor;
      boardView.gameInfo.innerHtml = "TURN: "+turns.toString()+"/"+boardModel.maxSteps.toString()+" | " +"SCORE: "+boardModel.score.toString();
      colorButton.onClick.listen((e)
      {
        boardModel.setColor(color);
        updateColors();
        if(boardModel.checkWin())
        {
          thisLevel++;
          turns=0;
          boardView.statusBar.innerHtml = "YOU WIN!";
          delayLoadLevel(thisLevel);
        }
        else
        {
          if(turns<boardModel.maxSteps)
          {
            turns++;
            boardView.gameInfo.innerHtml = "TURN: "+turns.toString()+"/"+boardModel.maxSteps.toString()+" | " +"SCORE: "+boardModel.score.toString();
          }
          else
          {
            boardView.statusBar.innerHtml = "YOU LOOSE! :-(";
            loadGameOver();
          }
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