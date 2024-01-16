import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:graduation_project/start_up_screen.dart';

import '../commen_component/app_buttons/custom_button.dart';
import '../swap.dart';

final controller = PageController(initialPage: 0);

class PageViewScreen extends StatelessWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          PageViewItem(),
          PageViewItem2(),
        ],
      ),
    );
  }
}

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 342.w,
            height: 350.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15).r),
              elevation: 5,
              color: const Color(0xffF5F5F5),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Image.asset('assets/image/Frame.png'),
                  SizedBox(height: 20.h),
                  Text(
                    'Sight Beyond Sight',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'AI Object Detection for\nthe Visually Impaired',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  SmoothPageIndicator(
                    controller: controller, // PageController
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFF86BEFF),
                      dotColor: Color(0xFFB9B9B9),
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          CustomButton(
            width: 342,
            height: 40,
            color: const Color(0xFF86BEFF),
            text: 'Next',
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
    );
  }
}
class PageViewItem2 extends StatelessWidget {
  const PageViewItem2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 342.w,
            height: 350.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15).r),
              elevation: 5,
              color: const Color(0xffF5F5F5),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Image.asset('assets/image/Layer2.png'),
                  SizedBox(height: 20.h),
                  Text(
                    'Building Connections',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Add Friends for Enhanced\nObject Detection Accessibility',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  SmoothPageIndicator(
                    controller: controller, // PageController
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFF86BEFF),
                      dotColor: Color(0xFFB9B9B9),
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: 160,
                  height: 40,
                  color: const Color(0xffF5F5F5),
                  text: 'Back',
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                CustomButton(
                  width: 160,
                  height: 40,
                  color: const Color(0xFF86BEFF),
                  text: 'Finish',
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return const SwapPage();
                    }));

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

