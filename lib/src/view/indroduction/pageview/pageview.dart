import 'package:flutter/material.dart';
import 'package:mabook/src/view/indroduction/pageview/page_1.dart';
import 'package:mabook/src/view/indroduction/pageview/page_2.dart';
import 'package:mabook/src/view/indroduction/pageview/page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewScreen extends StatelessWidget {
   PageViewScreen({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 700,
              width: 400,
              child: PageView(
                controller: _controller,
                children:const [
                  Page1(),
                  Page2(),
                  Page3()
                ],
              ),
            ),
             SmoothPageIndicator(
          controller: _controller,
           count: 3,
           effect: const SwapEffect(
                  activeDotColor: Colors.black,
                  dotColor: Color.fromARGB(255, 78, 78, 78),
                  spacing: 12,
                  dotHeight: 15,
                  dotWidth: 15
           ),
          
          )
          ],
        ),
       
      ),
    );
  }
}
