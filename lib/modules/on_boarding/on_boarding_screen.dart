import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard1.png',
      title: 'On Boarding Title 1',
      body: 'On Boarding body 1',
    ),
    BoardingModel(
      image: 'assets/images/onboard2.png',
      title: 'On Boarding Title 2',
      body: 'On Boarding body 2',
    ),
    BoardingModel(
      image: 'assets/images/onboard3.png',
      title: 'On Boarding Title 3',
      body: 'On Boarding body 3',
    ),
  ];

  var boardingController = PageController();

  bool isLast = false;


  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
        {
          navigateAndFinish(context, LoginScreen());
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              submit();
            },
            child: const Text(
              'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 10.0,
                    expansionFactor: 4.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: ExactAssetImage(
                  model.image,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              model.body,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      );
}
