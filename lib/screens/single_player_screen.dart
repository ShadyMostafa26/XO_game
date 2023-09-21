import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_game/providers/game_logic_provider.dart';
import 'package:tic_tac_game/screens/information_screen.dart';

class SinglePlayerScreen extends StatefulWidget {
  final String singlePlayer;



  const SinglePlayerScreen({ Key? key, required this.singlePlayer}) : super(key: key);

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final AlertDialog alertDialog = AlertDialog(
        content: SizedBox(
      height: 130,
      child: Column(
        children: [
          Text('Are u sure you want to leave the game?'),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<PlayerProvider>(context,listen: false).resetGame().then((value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformationScreen(),
                      ),
                          (route){
                        return false;
                      },
                    );

                  });
                },
                child: Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    ));

    var playerProvider = Provider.of<PlayerProvider>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).shadowColor.withOpacity(0.5),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return alertDialog;
                  },
                );
              },
            ),
            centerTitle: true,
            title: Text('X-O '),
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/xo4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(

                    children: [
                     /*  SwitchListTile.adaptive(
                        title: (!playerProvider.isSWitched)
                            ? const Text(
                          'Turn ON two player mode',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                            : const Text(
                          'Turn OFF two player mode',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        activeColor: Colors.blueAccent,
                        inactiveTrackColor: Colors.grey,
                        value: Provider.of<PlayerProvider>(context).isSWitched,
                        onChanged: (value) {
                          Provider.of<PlayerProvider>(context, listen: false).changeGameMode();
                        },
                      ),*/
                      SizedBox(height: 5),
                      (Provider.of<PlayerProvider>(context).activePlayer) == 'X'? Text(
                        'IT\'s ${widget.singlePlayer} turn'
                            .toUpperCase(),
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      )
                          :
                      Text('IT\'s Computer turn'.toUpperCase(), style: TextStyle(fontSize: 30, color: Colors.black)) ,
                      SizedBox(height: 100),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          padding: EdgeInsets.all(16),
                          mainAxisSpacing: 9,
                          crossAxisSpacing: 9,
                          children: List.generate(
                            9,
                            (index) => InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: playerProvider.gameOver
                                  ? null
                                  : () => onTab(index, context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).shadowColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: playerProvider.playerX.contains(index)
                                      ? Text('X',
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 48))
                                      : playerProvider.playerO.contains(index)
                                          ? Text('O',
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 48))
                                          : Text(''),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (playerProvider.gameOver && playerProvider.winner != "")
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (Provider.of<PlayerProvider>(context).activePlayer) == 'X'? Text(
                                '${'Computer' + " " + 'is the winner'}',
                                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                              ) : Text(
                                '${widget.singlePlayer} is The Winner',
                                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                              ) ,
                            )
                          : (playerProvider.turn == 9)
                              ? Text(
                                  'Its DRAW',
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                                )
                              : SizedBox(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          Provider.of<PlayerProvider>(context, listen: false)
                              .resetGame();
                        },
                        icon: Icon(Icons.replay),
                        label: Text("Restart"),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        playerProvider.gameOver? ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 20,
        ) : SizedBox.shrink(),
      ],
    );
  }

  onTab(int index, context) {
    Provider.of<PlayerProvider>(context, listen: false).changeActivePlayer(index);
  }
}
