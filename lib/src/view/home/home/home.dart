import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/doctor_controller.dart';
import 'package:mabook/src/controller/helth_article_controller.dart';
import 'package:mabook/src/view/home/article/w_helth_article.dart';
import 'package:mabook/src/view/home/home/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());
    final HealthArticleController helthController =
        Get.put(HealthArticleController());
    helthController.loadArticles();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              SearchButton(),
              streamBuilder(),
              const SizedBox(
                height: 10,
              ),
              topdoctor(doctorController),
              const SizedBox(
                height: 20,
              ),
              const HealthArticlePage(
                articleCount: 4,
              )
            ],
          ),
        );
      }),
    );
  }
}
