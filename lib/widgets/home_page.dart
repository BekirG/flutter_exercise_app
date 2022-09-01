import 'package:exercises_app/repository/info_repository.dart';
import 'package:exercises_app/repository/exercise_list_repository.dart';
import 'package:exercises_app/services/data_service.dart';
import 'package:exercises_app/widgets/exercises_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:exercises_app/app_color.dart';
import "package:exercises_app/extensions/string_extension.dart";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();    
    if(ref.read(dataServiceProvider).isRequest == false){
      ref.read(exerciseProvider).downLoadExerciseList();    
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final infoRepository = ref.watch(infoProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Training",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.fitness_center,
                    size: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColor.homePageGradientFirst.withOpacity(0.8),
                      AppColor.homePageGradientSecond.withOpacity(0.3)
                    ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(80),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 10),
                        blurRadius: 10,
                        color: AppColor.homePageGradientSecond.withOpacity(0.2),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 30, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Exercise App",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Select Bodypart and Equipment. ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Display How the Exercise is Done.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: const [
                    Text(
                      "Body Parts",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: infoRepository.info.length.toDouble() ~/ 2,
                    itemBuilder: (_, index) {
                      int a = index * 2;
                      int b = index * 2 + 1;

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(infoProvider).getBodyPart(
                                    ref.read(infoProvider).info[a].title);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ExercisesPage()));
                              },
                              child: Container(
                                height: 150,
                                width:
                                    (MediaQuery.of(context).size.width - 90) /
                                        2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  /*image:  DecorationImage(
                                        image: AssetImage(
                                          infoRepository.info[index].img,
                                        ),
                                      ), */
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: AppColor.homePageGradientSecond
                                            .withOpacity(0.3)),
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: AppColor.homePageGradientSecond
                                            .withOpacity(0.3)),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          infoRepository.info[a].img,
                                          width: 120,
                                          height: 120,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          infoRepository.info[a].title
                                              .toTitleCase(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(infoProvider).getBodyPart(
                                    ref.read(infoProvider).info[b].title);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ExercisesPage()));
                              },
                              child: Container(
                                height: 150,
                                width:
                                    (MediaQuery.of(context).size.width - 90) /
                                        2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: AppColor.homePageGradientSecond
                                            .withOpacity(0.3)),
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(5, 5),
                                        color: AppColor.homePageGradientSecond
                                            .withOpacity(0.3)),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          infoRepository.info[b].img,
                                          width: 120,
                                          height: 120,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          infoRepository.info[b].title
                                              .toTitleCase(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
