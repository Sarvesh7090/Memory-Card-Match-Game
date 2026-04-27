import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/app/view/memory_game/presentation/providers/game_notifier.dart';

class GamePage extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final state = ref.watch(gameProvider);
   final notifier = ref.read(gameProvider.notifier);
   return Scaffold(
     appBar: AppBar(
       title:  Text("Moves : ${state.moves}"),
       actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.refresh))
       ],
     ),
     body: GridView.builder(
       itemCount: state.cards.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
           (crossAxisCount: 4,
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
         ),
         itemBuilder: (context,index){
           final card = state.cards[index];
           return InkWell(
             onTap: () {
               print("click on card");
               notifier.flipCard(index);
             },
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.deepPurple,
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Center(
                 child: Text(
                   card.isFlipped || card.isMatch ? card.emoji : "?",style: TextStyle(fontSize: 30),
                 ),
               ),
             ),
           );
         }),
   );
  }

}