import 'package:flutter/widgets.dart';

import 'home_screen/Home.dart';
import 'start_up_screen.dart';

class SwapPage extends StatelessWidget {
  const SwapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  PageView(
      physics: const PageScrollPhysics(),
      children: const[
        StartUpScreen(),
        HomeScreen(),
      ],
    );
  }
}