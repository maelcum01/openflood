part of main;
/* The Controller class:
    The constructor takes only one parameter
    the levels as a list of hash-maps
 */
class GameController
{
  List levels = [];
  Map currentLevel = {};
  var boardView = null;
  var boardModel = null;
  var thisLevel = 0;
  var turns = 0;

  GameController(var levels)
  {
    this.levels = levels;
    print(levels);
  }

  Timer delayLoadLevel(var level)
  {
    return new Timer(const Duration(seconds: 5), () => this.loadLevel(level));
  }

  Timer loadGameOver()
  {
    return new Timer(const Duration(seconds: 2), () => this.gameOver());
  }

  loadLevel(var level)
  {
    Map currentLevel = levels[level]; // get level by index
    this.currentLevel = currentLevel;
    this.boardModel = new BoardModel(currentLevel["level"], currentLevel["boardSize"],currentLevel["colors"], currentLevel["board"],currentLevel["maxSteps"]); // instantiate Board Model with the hash-map string parameters
    this.boardView = new BoardView(boardModel.x,boardModel.y,boardModel.colors);  // instantiate the view upon the model
    initButtons();
    updateColors();
  }

  gameInfo()// render game info
  {
    boardView.gameInfo.innerHtml = "TURN: "+turns.toString()+"/"+boardModel.maxSteps.toString()+" | " +"SCORE: "+boardModel.score.toString();
  }
  gameOver() // render game over view
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
  /* Initializes the Button Bar with as many buttons as there are colors.
     An click-event listener is placed for each of those buttons
     modifying and manipulating the model upon the triggered event.
     Also includes the execution of the actual game logic which determines
     a win or loose of the player.
   */
  initButtons()
  {
    for(var colorButton in boardView.buttonBar.children)
    {
      var color = colorButton.style.backgroundColor;  // get the button's color
      gameInfo();                                     // render game info
      colorButton.onClick.listen((e)
      {
        boardModel.setColor(color);                   // manipulate model
        updateColors();                               // re-render view
        if(boardModel.checkWin())
        {
          thisLevel++;
          turns=0;
          boardView.statusBar.innerHtml = "YOU WIN!";
          delayLoadLevel(thisLevel);
        }
        else
        {
          if(turns<=boardModel.maxSteps-1)
          {
            ++turns;
            gameInfo();                               // re-render game info
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
  updateColors() // updates the colors inside the model's div elements
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