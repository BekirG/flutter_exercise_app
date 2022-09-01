import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:exercises_app/models/exercise_model.dart';

class DataService {
  final String baseUrl = 'https://exercisedb.p.rapidapi.com/exercises';

  static const Map<String, String> _headers = {
    'X-RapidAPI-Key': 'Your API Key',
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
  };

  bool isRequest = false;
 
  List<ExerciseList> exerciseList = [];
  Future<List<ExerciseList>> exerciseListDownload() async {
    http.Response response =
        await http.get(Uri.parse(baseUrl), headers: _headers);

    if (response.statusCode == 200) {
      isRequest = true;
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            exerciseList.add(ExerciseList.fromMap(map));
          }
        }
      }

      return exerciseList;
    } else {
      throw Exception('Download failed. ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) => DataService());
