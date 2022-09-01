import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoRepository extends ChangeNotifier {
  String bodyPart = "";

  final List<Info> info = [
    Info(0, "back", "assets/images/part0.png"),
    Info(1, "cardio", "assets/images/part1.png"),
    Info(2, "chest", "assets/images/part2.png"),
    Info(3, "lower arms", "assets/images/part3.png"),
    Info(4, "lower legs", "assets/images/part4.png"),
    Info(5, "neck", "assets/images/part5.png"),
    Info(6, "shoulders", "assets/images/part6.png"),
    Info(7, "upper arms", "assets/images/part7.png"),
    Info(8, "upper legs", "assets/images/part8.png"),
    Info(9, "waist", "assets/images/part9.png"),
  ];

  getBodyPart(bodyPart) {
    this.bodyPart = bodyPart;
  }
}

final infoProvider = ChangeNotifierProvider((ref) {
  return InfoRepository();
});



class Info {
  int id;
  String title;
  String img;

  Info(this.id, this.title, this.img);
}



