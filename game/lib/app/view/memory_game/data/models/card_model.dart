class CardEntity {
  int id;
  String emoji;
  bool isFlipped;
  bool isMatch;

  CardEntity({
    required this.id,
    required this.emoji,
     this.isFlipped = false,
     this.isMatch = false
});

  CardEntity copyWith({
    bool? isFlipped,
    bool? isMatch,
}){
    return CardEntity(
        id: id,
        emoji: emoji,
        isFlipped: isFlipped ?? this.isFlipped,
        isMatch: isMatch ?? this.isMatch);
  }
}