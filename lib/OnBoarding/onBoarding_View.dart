import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/color_extension.dart';
import 'package:graduation_project/commen_widget/round_button.dart';
import 'package:graduation_project/start_up_screen.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingView();
}

class _OnBoardingView extends State<OnBoardingView> {
  CarouselController buttonCarouselController = CarouselController();

  List goalArr = [
    {
      "image": "assets/image/eye.jpg",
      "title": "Improve Shape",
      "subtitle":
          "I have a low amount of body fat\nand need / want to build more\nmuscle"
    },
    {
      "image": "assets/image/help.jpeg",
      "title": "Lean & Tone",
      "subtitle":
          "I’m “skinny fat”. look thin but have\nno shape. I want to add learn\nmuscle in the right way"
    },
    {
      "image": "assets/image/world.png",
      "title": "Lose a Fat",
      "subtitle":
          "I have over 20 lbs to lose. I want to\ndrop all this fat and gain muscle\nmass"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10 , right: 10),
          child: Column(
            children: [
              Text(
                "What is BASEERA ?",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "We Are here to help you \n in ",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.gray, fontSize: 13),
              ),
              const  SizedBox(height: 20,),
              Stack(
                children: [
                  Center(
                    child: CarouselSlider(
                      items: goalArr
                          .map(
                            (gObj) => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: EdgeInsets.only(
                                top: 10,
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      gObj["image"].toString(),
                                      width: media.width * 0.5,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.1,
                                    ),
                                    Text(
                                      gObj["title"].toString(),
                                      style: TextStyle(
                                          color: TColor.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      width: media.width * 0.1,
                                      height: 1,
                                      color: TColor.white,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Text(
                                      gObj["subtitle"].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: TColor.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        aspectRatio: 0.74,
                        initialPage: 0,
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 30,),
              RoundButton(
                  title: " Lets Start",
                  onPressed: () {
                    navigatorToStartUpScreen();
                  }),
            ],
          ),
        ),
      ),
    );
  }
  void navigatorToStartUpScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const StartUpScreen()));
  }
}
