import 'package:flutter/material.dart';
import 'dart:math';

extension ContainsAll on List {
  bool containsAll(int x, int y, int z) {
    return contains(x) && contains(y) && contains(z);
  }
}

class PlayerProvider with ChangeNotifier {
  String x = 'X';
  String o = 'Y';
  String activePlayer = 'X';
  String winner = '';
  bool gameOver = false;
  int turn = 0;


  bool isSWitched = false;
  Future<void> changeGameMode() async{
    isSWitched =  !isSWitched;
    notifyListeners();
  }

  List<int> playerX = [];
  List<int> playerO = [];

  void playGame(int index) {
    if (activePlayer == 'X')
      playerX.add(index);
    else
      playerO.add(index);
  }

  void changeActivePlayer(int index) {
    if ((playerX.isEmpty || !playerX.contains(index)) &&
        (playerO.isEmpty || !playerO.contains(index))) {
      playGame(index);
      turn ++;
      checkWinner();
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';


      if (!isSWitched && turn != 9 && !gameOver) {
        Future.delayed(Duration(seconds: 1), () async {
          await autoPlay(activePlayer);
          checkWinner();
          turn++;
          activePlayer = (activePlayer == 'X') ? 'O' : 'X';

        });
      }
    }

    if(turn == 9){gameOver = true;}
    print(turn.toString());
    notifyListeners();
  }

  Future<void> autoPlay(String activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (!playerX.contains(i) && !playerO.contains(i)) {
        emptyCells.add(i);
      }
    }
    Random random = Random();
    int randomIndex = random.nextInt(emptyCells.length);
    index = emptyCells[randomIndex];
    playGame(index);
    notifyListeners();
  }

  void checkWinner() {
    if (playerX.containsAll(0, 1, 2) ||
        playerX.containsAll(3, 4, 5) ||
        playerX.containsAll(6, 7, 8) ||
        playerX.containsAll(0, 3, 6) ||
        playerX.containsAll(1, 4, 7) ||
        playerX.containsAll(2, 5, 8) ||
        playerX.containsAll(0, 4, 8) ||
        playerX.containsAll(2, 4, 6)) {
      winner = 'X';
      gameOver = true;
      notifyListeners();
    }
   else if (playerO.containsAll(0, 1, 2) ||
        playerO.containsAll(3, 4, 5) ||
        playerO.containsAll(6, 7, 8) ||
        playerO.containsAll(0, 3, 6) ||
        playerO.containsAll(1, 4, 7) ||
        playerO.containsAll(2, 5, 8) ||
        playerO.containsAll(0, 4, 8) ||
        playerO.containsAll(2, 4, 6)) {
      winner = 'O';
      gameOver = true;
      notifyListeners();
    }

    else{
      winner = '';
      notifyListeners();
    }

    print(winner);
    notifyListeners();

  }

  Future <void> resetGame() async{
    playerX = [];
    playerO = [];
    activePlayer = 'X';
    isSWitched = false;
    gameOver = false;
    turn = 0;
    notifyListeners();
  }
}
