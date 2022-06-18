import 'package:comma/layout/home/home.dart';
import 'package:comma/modules/home/home.dart';
import 'package:comma/modules/login/Login_student/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingModels {
  final String image;
  final String title;
  final String body;

  boardingModels({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardingController = PageController();
  bool isLast = false;

  List<boardingModels> boarding = [
    boardingModels(
      image: "assets/images/splash2.png",
      title: "Better way to learning is calling you!",
      body: "Impeet viverra vivamus porttior ules ac vulte lectus velit sen lectus ue ",
    ),
    boardingModels(
      image: "assets/images/splash3.png",
      title: "Find yourself  by doing whatever you do !",
      body: "Impeet viverra vivamus porttior ules ac vulte lectus velit sen lectus ue ",
    ),
    boardingModels(
      image: "assets/images/splash4.png",
      title: "It’s not just learning,It’s a promise!",
      body: "Impeet viverra vivamus porttior ules ac vulte lectus velit sen lectus ue ",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login_Student();
                }));
              },
              child: Text(
                "Skip",
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: (
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) => OnBoarding(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.blue,
                      spacing: 5,
                      dotWidth: 10,
                      dotHeight: 10,
                      expansionFactor: 4,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue[900],
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return Login_Student();
                      }), (Route<dynamic> route) => false);
                    } else {
                      boardingController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget OnBoarding(boardingModels models) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage("${models.image}")),
          SizedBox(height: 20,),
          Text(
            "${models.title}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: HexColor('#0B121F')
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "${models.body}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: HexColor('#9FA3A9')),
          ),
        ],
      );
}
