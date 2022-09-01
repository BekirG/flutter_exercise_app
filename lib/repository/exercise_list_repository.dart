import 'package:exercises_app/models/exercise_model.dart';
import 'package:exercises_app/services/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseProvider = ChangeNotifierProvider((ref) {
  return ExerciseListRepository(ref.watch(dataServiceProvider));
});

class ExerciseListRepository extends ChangeNotifier {
  final List selectedExerciseList = [];
  List<ExerciseList>? downloadedExerciseList;
  final DataService dataService;

  ExerciseListRepository(this.dataService);
  
  /* to test.
  
  final List exerciseList = [
    {
      "bodyPart": "waist",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/0001.gif",
      "id": "0001",
      "name": "3/4 sit-up",
      "target": "abs",
    },
    {
      "bodyPart": "waist",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/0002.gif",
      "id": "0002",
      "name": "45° side bend",
      "target": "abs",
    },
    {
      "bodyPart": "waist",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/0003.gif",
      "id": "0003",
      "name": "air bike",
      "target": "abs",
    },
    {
      "bodyPart": "upper legs",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/1512.gif",
      "id": "1512",
      "name": "all fours squad stretch",
      "target": "quads",
    },
    {
      "bodyPart": "waist",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/0006.gif",
      "id": "0006",
      "name": "alternate heel touchers",
      "target": "abs",
    },
    {
      "bodyPart": "back",
      "equipment": "cable",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/0007.gif",
      "id": "0007",
      "name": "alternate lateral pulldown",
      "target": "lats",
    },
    {
      "bodyPart": "lower legs",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/1368.gif",
      "id": "1368",
      "name": "ankle circles",
      "target": "calves",
    },
    {
      "bodyPart": "back",
      "equipment": "body weight",
      "gifUrl": "http://d205bpvrqc9yn1.cloudfront.net/3293.gif",
      "id": "3293",
      "name": "archer pull up",
      "target": "lats",
    }
  ];
*/

  Future<void> downLoadExerciseList() async {
    downloadedExerciseList =
        await dataService.exerciseListDownload();
    notifyListeners();
  }

  getExerciseList(bodyPart, equipment) {
    
    for (var i = 0; i < downloadedExerciseList!.length; i++)  
    {
       
      if (equipment == "all") {
        if (downloadedExerciseList![i].bodyPart == bodyPart) {
          selectedExerciseList.add(downloadedExerciseList![i]);
        }
      } else {
        if (downloadedExerciseList![i].bodyPart == bodyPart && downloadedExerciseList![i].equipment == equipment) {
          selectedExerciseList.add(downloadedExerciseList![i]);
        }
      }
    }
    notifyListeners();
  }

  resetExerciseList() {
    selectedExerciseList.clear();
    notifyListeners();
  }
}
