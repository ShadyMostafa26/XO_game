import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_game/providers/game_logic_provider.dart';
import 'package:tic_tac_game/screens/single_player_screen.dart';
import 'package:tic_tac_game/screens/two_players_screen.dart';

class InformationScreen extends StatelessWidget {
  final TextEditingController singlePlayer = TextEditingController();
  final TextEditingController firstPlayer = TextEditingController();
  final TextEditingController secondPlayer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.orange,
                Colors.orange,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'Tic Tac',
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/images/titlexo.png',
                      width: 200,
                    ),
                    SizedBox(height: 35),
                    ExpansionTile(
                      title: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: null,
                        child: Text(
                          'Single Player',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      children: [
                        TextField(
                          controller: singlePlayer,
                          onSubmitted: (value) {
                            Provider.of<PlayerProvider>(context, listen: false).isSWitched = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SinglePlayerScreen(
                                    singlePlayer: singlePlayer.text,
                                  );
                                },
                              ),
                            ).then((value) => singlePlayer.clear());
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter your Name',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
///////////////////////////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 10),
                    ExpansionTile(

                      title: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: null,
                        child: Text(
                          'Two Players',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      children: [
                        SizedBox(height: 10),
                        TextField(
                          controller: firstPlayer,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'First Player',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: secondPlayer,
                          onSubmitted: (value) {
                            Provider.of<PlayerProvider>(context, listen: false)
                                .isSWitched = false;
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return TwoPlayerScreen(
                                  firstPlayer: firstPlayer.text,
                                  secondPlayer: secondPlayer.text,
                                );
                              },
                            ),
                            ).then((value) {
                              firstPlayer.dispose();
                              secondPlayer.dispose();
                            });
                            Provider.of<PlayerProvider>(context, listen: false)
                                .changeGameMode();
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Second Player',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
