import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final equipmentProvider = Provider((ref) {
  return EquipmentRepository();
});

class EquipmentRepository extends ChangeNotifier {
  final Map<int, String> equipment = {
    28: "all",
    0: "assisted",
    1: "band",
    2: "barbell",
    3: "body weight",
    4: "bosu ball",
    5: "cable",
    6: "dumbbell",
    7: "elliptical machine",
    8: "ez barbell",
    9: "hammer",
    10: "kettlebell",
    11: "leverage machine",
    12: "medicine ball",
    13: "olympic barbell",
    14: "resistance band",
    15: "roller",
    16: "rope",
    17: "skierg machine",
    18: "sled machine",
    19: "smith machine",
    20: "stability ball",
    21: "stationary bike",
    22: "stepmill machine",
    23: "tire",
    24: "trap bar",
    25: "upper body ergometer",
    26: "weighted",
    27: "wheel roller"
  };
}