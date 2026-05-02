import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/app/view/memory_game/data/models/card_model.dart';
import 'package:game/app/view/memory_game/presentation/providers/game_state.dart';

final gameProvider =
StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.initial()) {
    startGame();
  }

  int? firstIndex;
  bool isBusy = false;

  /// Start / Restart Game
  void startGame() {
    final emojis = ['🍎','🐶','🚗','⭐','❤️','🎮','👑','⚽'];

    final cards = [...emojis, ...emojis]
        .asMap()
        .entries
        .map((e) => CardEntity(
      id: e.key,
      emoji: e.value,
    ))
        .toList();

    cards.shuffle(math.Random());

    state = GameState(
      cards: cards,
      moves: 0,
    );

    firstIndex = null;
    isBusy = false;
  }

  /// Flip Card Logic
  Future<void> flipCard(int index) async {
    if (index < 0 || index >= state.cards.length) return;
    if (isBusy) return;

    final cards = [...state.cards];

    // Prevent tapping same/open/matched card
    if (cards[index].isFlipped || cards[index].isMatch) return;

    // Flip current card
    cards[index] = cards[index].copyWith(isFlipped: true);

    state = state.copyWith(cards: cards);

    // First selection
    if (firstIndex == null) {
      firstIndex = index;
      return;
    }

    final secondIndex = index;

    // MATCH CASE
    if (cards[firstIndex!].emoji ==
        cards[secondIndex].emoji) {
      cards[firstIndex!] =
          cards[firstIndex!].copyWith(isMatch: true);
      cards[secondIndex] =
          cards[secondIndex].copyWith(isMatch: true);

      state = state.copyWith(
        cards: cards,
        moves: state.moves + 1,
      );

      firstIndex = null;

      _checkWin();
      return;
    }

    // WRONG MATCH CASE
    isBusy = true;

    state = state.copyWith(
      cards: cards,
      moves: state.moves + 1,
    );

    // Delay to show both cards
    await Future.delayed(const Duration(milliseconds: 700));

    // Flip back both cards
    cards[firstIndex!] =
        cards[firstIndex!].copyWith(isFlipped: false);
    cards[secondIndex] =
        cards[secondIndex].copyWith(isFlipped: false);

    state = state.copyWith(cards: cards);

    firstIndex = null;
    isBusy = false;
  }

  /// Check if game is completed
  void _checkWin() {
    final isWin =
    state.cards.every((card) => card.isMatch);

    if (isWin) {
      print("🎉 You Win!");
    }
  }
}