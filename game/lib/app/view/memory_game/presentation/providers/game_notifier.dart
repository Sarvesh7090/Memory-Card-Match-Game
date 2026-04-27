
import 'dart:math' as myth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/app/view/memory_game/data/models/card_model.dart';
import 'package:game/app/view/memory_game/presentation/providers/game_state.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref){
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.initial()) {
    startGame();
  }
  int? firstIndex;

  void startGame(){
    final emojis = ['🍎','🐶','🚗','⭐','❤️','🎮','👑','⚽'];

    final cards = [...emojis,...emojis].asMap().entries.map((e){
      return CardEntity(id: e.key, emoji: e.value);
    }).toList();

    cards.shuffle(myth.Random());

    state = GameState(cards: cards,moves: 0);
    firstIndex = null;
  }

  void flipCard( int index){
    final cards = [...state.cards];
    if(cards[index].isFlipped || cards[index].isMatch) return;
    print("firstIndex $firstIndex");
    cards[index] = cards[firstIndex!].copyWith(isFlipped: true);
    if(firstIndex == null){
      firstIndex = index;

      return;
    }

    final secondIndex = index;
    print("condition check ${cards[firstIndex!].emoji == cards[secondIndex].emoji}");
    if(cards[firstIndex!].emoji == cards[secondIndex].emoji){
      cards[firstIndex!] = cards[firstIndex!].copyWith(isMatch: true);
      cards[secondIndex] = cards[secondIndex].copyWith(isMatch: true);
    }
 firstIndex = null;
    state = state.copyWith(cards: cards,moves: state.moves + 1);
  }
}