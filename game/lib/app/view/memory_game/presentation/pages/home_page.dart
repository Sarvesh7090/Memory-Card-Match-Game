import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/app/view/memory_game/presentation/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => GamePage()));
            },
            child: Text("Start Game")),
      ),
    );
  }
}
