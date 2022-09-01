import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final selectedExerciseProvider =
    ChangeNotifierProvider((ref) => SelectedExerciseRepository());

class SelectedExerciseRepository extends ChangeNotifier {
  Map<String, String> selectedExerciseList = {};

  addSelectedExercise(
      {required String bodyPart,
      required String equipment,
      required String gifUrl,
      required String id,
      required String name,
      required String target}) {
    selectedExerciseList["bodyPart"] = bodyPart;
    selectedExerciseList["equipment"] = equipment;
    selectedExerciseList["gifUrl"] = gifUrl;
    selectedExerciseList["id"] = id;
    selectedExerciseList["name"] = name;
    selectedExerciseList["target"] = target;
    notifyListeners();
  }

  resetSelectedExercise() {
    selectedExerciseList.clear();
    notifyListeners();
  }
}