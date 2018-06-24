import 'dart:html';
import 'dart:async';
import 'dart:convert';

part 'src/BoardModel.dart';
part 'src/GameController.dart';
part 'src/BoardView.dart';

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






