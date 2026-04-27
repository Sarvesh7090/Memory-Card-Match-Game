import 'package:game/app/view/memory_game/data/models/card_model.dart';

class GameState {
  final List<CardEntity> cards;
  final int moves;

  GameState({
    required this.cards,
    required this.moves
});

factory GameState.initial(){
  return GameState(cards: [], moves: 0);
}

  GameState copyWith({
     List<CardEntity>? cards,
     int? moves,
}){
    return GameState(
        cards: cards ?? this.cards,
        moves: moves ?? this.moves);
  }
}