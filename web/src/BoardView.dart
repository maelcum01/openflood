part of 'main.dart';
/* The View Class:
    Initializes and renders the DOM and HTML elements
    The constructors parameters are the boards size
    and a list of the colors present in each game or level.
 */
class BoardView
{
  var rootElem = null;
  var boardElem = null;
  var width = 50.0;
  var height = 50.0;
  var buttonBar = null;
  var titleBar = null;
  var statusBar = null;
  var gameInfo = null;
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
    this.rootElem = querySelector('#main'); // set root to #main element
    rootElem.children.clear();
    rootElem.style.width = "360px";

    this.titleBar = new Element.tag("H1");
    this.titleBar.innerHtml = "";
    rootElem.children.add(titleBar);

    this.width = double.parse(rootElem.style.width.replaceAll("px", ""))/x; // calculate pixel per tile
    this.height = width;
    this.boardElem = new Element.div(); // create game board element within the root element
    rootElem.children.add(boardElem);

    for(var rowY = 0; rowY< y;rowY++) // create y rows of div elements within the board div element
        {
      var rowElem = new Element.div();
      boardElem.children.add(rowElem);
      for (var tileX = 0; tileX < x;tileX++) // create x tiles of div elements within each row div element
          {
        var tileElem = new Element.div();
        rowElem.append(tileElem);
        tileElem.style.display = "inline-block";  // set style parameters for each tile
        tileElem.style.border = "solid 1px grey";
        tileElem.style.width = (width * 0.95).toString()+"px";
        tileElem.style.height = height.toString()+"px";
        tileElem.classes.add("tileElem");
      }
    }
    this.gameInfo = new Element.div();
    rootElem.children.add(gameInfo);
    this.buttonBar = new Element.div(); // create button bar div element
    this.buttonBar.classes.add("buttonBar");
    rootElem.children.add(buttonBar); // append button bar to root div element
    for(var color in this.colors)     // create button elements of each color from json list, within the button bar div element
        {
      var colorButton = new ButtonElement();
      colorButton.classes.add("colorButton");
      buttonBar.children.add(colorButton);
      colorButton.style.backgroundColor= color; // set background to json list color
      colorButton.style.width =(width * 0.95).toString()+"px";
      colorButton.style.height= height.toString()+"px";
    }
    this.statusBar = new Element.div();
    rootElem.children.add(this.statusBar);
  }
}