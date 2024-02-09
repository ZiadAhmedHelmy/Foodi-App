import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/view/HomePage/HomePage.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Model/Models/ContentModel.dart';
import '../Model/Components/CustumText.dart';
import 'HomePage/Login_RegisterPages/LoginPage.dart';

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
    LocalData.setData(key: SharedKey.firstTime, value: false);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    text: "Next",
                    btnHeight: 60,
                    color: const Color(0xFFFF5C28),
                    textColor: Colors.white,
                    onTap: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  const Login_Register_Page(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }),
              ),
              const SizedBox(
                height: 25,
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      text: currentIndex == 0 ? " " :"Back",
                      btnHeight: 60,
                      color:currentIndex==0 ? Colors.transparent : AppColor.white,
                      textColor:currentIndex==0 ? AppColor.white : AppColor.orange ,
                      borderColor:currentIndex==0 ?AppColor.white : AppColor.orange,
                      borderWidth: 2,
                      onTap: () {
                        currentIndex==0 ?  null :   _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );

                      }),
                ),


          ],
        ),
      ),
    );
  }
}



