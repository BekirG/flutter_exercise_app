class ExerciseList {
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String id;
  final String name;
  final String target;

  ExerciseList(
      {required this.bodyPart,
      required this.equipment,
      required this.gifUrl,
      required this.id,
      required this.name,
      required this.target});

  factory ExerciseList.fromMap(Map<String, dynamic> m) => ExerciseList(
      bodyPart: m['bodyPart'],
      equipment: m['equipment'],
      gifUrl: m['gifUrl'],
      id: m['id'],
      name: m['name'],
      target: m['target']);
}
