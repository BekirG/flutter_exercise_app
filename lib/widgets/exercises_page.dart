import 'package:exercises_app/repository/info_repository.dart';
import 'package:exercises_app/repository/selected_exercise_repository.dart';
import 'package:exercises_app/widgets/selected_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:exercises_app/extensions/string_extension.dart";
import '../app_color.dart';
import 'package:gif/gif.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:exercises_app/repository/exercise_list_repository.dart';
import 'package:exercises_app/repository/equipment_repository.dart';

class ExercisesPage extends ConsumerStatefulWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends ConsumerState<ExercisesPage> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    String bodyPart = ref.read(infoProvider).bodyPart;
    WidgetsBinding.instance?.addPostFrameCallback((_) {     
      ref.read(exerciseProvider).resetExerciseList();
      ref.read(exerciseProvider).getExerciseList(bodyPart, "all");
    });
  }

  @override
  Widget build(BuildContext context) {
    final equipment = ref.watch(equipmentProvider).equipment;

    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.homePageGradientFirst.withOpacity(0.8),
              AppColor.homePageGradientSecond.withOpacity(0.3)
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(left: 0),
                          icon: const Icon(Icons.arrow_back),
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          ref.watch(infoProvider).bodyPart.toTitleCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20))),
                          child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: const Text("List by Equipments"),
                              value: _selected,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selected = newValue;
                                  String bodyPart =
                                      ref.read(infoProvider).bodyPart;
                                  ref
                                      .read(exerciseProvider)
                                      .resetExerciseList();
                                  ref
                                      .read(exerciseProvider)
                                      .getExerciseList(bodyPart, _selected);
                                });
                              },
                              items: equipment.entries
                                  .map<DropdownMenuItem<String>>(
                                      (MapEntry<int, String> e) {
                                return DropdownMenuItem<String>(
                                  value: e.value,
                                  child: Text(e.value.toTitleCase()),
                                );
                              }).toList(),
                            ),
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ), //header
            const SelectedExercises(),
          ],
        ),
      ),
    ));
  }
}

class SelectedExercises extends ConsumerStatefulWidget {
  const SelectedExercises({Key? key}) : super(key: key);

  @override
  _SelectedExercisesState createState() => _SelectedExercisesState();
}

class _SelectedExercisesState extends ConsumerState<SelectedExercises> {
  @override
  Widget build(BuildContext context) {
    final exerciseList = ref.watch(exerciseProvider);

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              itemCount: exerciseList.selectedExerciseList.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    ref.read(selectedExerciseProvider).resetSelectedExercise();
                    ref.read(selectedExerciseProvider).addSelectedExercise(
                          bodyPart: exerciseList.selectedExerciseList[index].bodyPart,
                          equipment: exerciseList.selectedExerciseList[index].equipment,                           
                          gifUrl: exerciseList.selectedExerciseList[index].gifUrl,
                          id: exerciseList.selectedExerciseList[index].id,
                          name: exerciseList.selectedExerciseList[index].name,                            
                          target: exerciseList.selectedExerciseList[index].target,                             
                        );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SelectedExercisePage()));
                  },
                  child: SizedBox(
                    height: 150,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(5, 10),
                                      blurRadius: 10,
                                      color: AppColor.homePageGradientSecond
                                          .withOpacity(0.2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black87),
                                ),
                                child: SizedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Gif(
                                      image: NetworkImage(exerciseList
                                              .selectedExerciseList[index].gifUrl),
                                      // if duration and fps is null, original gif fps will be used.
                                      autostart: Autostart.no,
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(                                   
                                      exerciseList.selectedExerciseList[index].name
                                          .toString()
                                          .toTitleCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        exerciseList.selectedExerciseList[index].equipment
                                            .toString()
                                            .toTitleCase(),
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashGradient: [
                            AppColor.homePageGradientFirst.withOpacity(0.8),
                            AppColor.homePageGradientSecond.withOpacity(0.3)
                          ],
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapGradient: [
                            AppColor.homePageGradientFirst.withOpacity(0.8),
                            AppColor.homePageGradientSecond.withOpacity(0.3)
                          ],
                          dashGapRadius: 0.0,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ), //Content
    );
  }
}
