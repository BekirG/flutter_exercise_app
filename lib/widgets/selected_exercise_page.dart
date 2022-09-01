import 'package:exercises_app/repository/selected_exercise_repository.dart';
import 'package:exercises_app/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gif/gif.dart';
import '../app_color.dart';
import "package:exercises_app/extensions/string_extension.dart";
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class SelectedExercisePage extends ConsumerStatefulWidget {
  const SelectedExercisePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectedExercisePageState();
}

class _SelectedExercisePageState extends ConsumerState<SelectedExercisePage>
    with SingleTickerProviderStateMixin {
  late final GifController gifController;
  @override
  void initState() {
    gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedExercise = ref.watch(selectedExerciseProvider);
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
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 480,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: [
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Gif(
                            controller: gifController,
                            image: NetworkImage(selectedExercise
                                .selectedExerciseList["gifUrl"]!),
                            autostart: Autostart.no,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            gifController.repeat();
                          },
                          icon: const Icon(Icons.play_arrow),
                          iconSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            gifController.stop();
                          },
                          icon: const Icon(Icons.pause),
                          iconSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 39, 75, 0.6))),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Exercise Information",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Exercise Name:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      selectedExercise
                                          .selectedExerciseList["name"]
                                          .toString()
                                          .toTitleCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Body Part:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      selectedExercise
                                          .selectedExerciseList["bodyPart"]
                                          .toString()
                                          .toTitleCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Equipment:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      selectedExercise
                                          .selectedExerciseList["equipment"]
                                          .toString()
                                          .toTitleCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Target:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      selectedExercise
                                          .selectedExerciseList["target"]
                                          .toString()
                                          .toTitleCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: ConvexButton.fab(
        icon: Icons.home,
        color: const Color.fromRGBO(0, 39, 75, 0.6),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        },
      ),
    );
  }
}
