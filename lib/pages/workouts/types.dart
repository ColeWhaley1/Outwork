class Deck {
  final List<Exercise> exercises;

  Deck(this.exercises);
}

class Exercise {
  final String name;
  final num timeDuration;

  Exercise(this.name, this.timeDuration); 
}
