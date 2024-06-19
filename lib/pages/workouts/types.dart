class Deck {
  final List<ExcerciseCard> cards;

  Deck(this.cards);
}

class ExcerciseCard {
  final String name;
  final num timeDuration;

  ExcerciseCard(this.name, this.timeDuration); 
}
