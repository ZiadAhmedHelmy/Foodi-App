import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/view/HomePage.dart';
import 'package:providerapp/view/LoginPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Model/Models/ContentModel.dart';
import '../Model/Components/CustumText.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(children: [
                SvgPicture.asset(
                  "assets/Shapes/Ellipse 10.svg",
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                ),

                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 400,
                          child: Image.asset(
                            contents[i].image ?? "",
                          ),
                        ),
                        // WelCome Text.........
                        Column(
                          children: [
                            Text(contents[i].title ?? "",
                                style: GoogleFonts.rubik(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              contents[i].discription ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                //Skip Button........
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomText(
                      text: 'Skip',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    IconButton(
                      enableFeedback: true,
                      onPressed: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      icon:
                          SvgPicture.asset("assets/Icons/Arrow-right-icon.svg"),
                    ),
                  ],
                ),
              ]),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: contents.length,
              effect: ExpandingDotsEffect(
                  spacing: 8.0,
                  dotHeight: 12,
                  dotWidth: 12,
                  radius: 6,
                  strokeWidth: 1.5,
                  dotColor: AppColor.lightGrey,
                  activeDotColor: const Color(0xFFFF5C28)),
            ),
            const SizedBox(
              height: 25,
            ),
            ...[
              CustomButton(
                  text: "Next",
                  btnHeight: 60,
                  color: const Color(0xFFFF5C28),
                  textColor: Colors.white,
                  onTap: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  Login_Register_Page(),
                        ),
                      );
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              if (currentIndex == 0)
                CustomButton(
                    text: "",
                    btnHeight: 60,
                    color: Colors.transparent,
                    textColor: Colors.white,
                    onTap: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }),
            ],
            if (currentIndex >= 1)
                 CustomButton(text: "Back", color: AppColor.white, btnHeight: 60 , borderColor: AppColor.orange,borderWidth: 2 ,textColor: AppColor.orange , onTap:() {
                   _controller.previousPage(
                     duration: const Duration(milliseconds: 300),
                     curve: Curves.easeOut,
                   );
                 }, ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}



