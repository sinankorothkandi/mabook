import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/helth_article_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/article/d_article.dart';
import 'package:mabook/src/view/home/article/w_helth_article.dart';

class HelthArticleScreen extends StatelessWidget {
  final int articleCount;
  const HelthArticleScreen({super.key, required this.articleCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: black,
            )),
        centerTitle: true,
        title: Text(
          'Helth Article',
          style: GoogleFonts.poppins(color: black),
        ),
      ),
      body: Obx(() {
        final HealthArticleController controller =
            Get.put(HealthArticleController());

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: controller.healthArticles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.87,
                    child: ListView.builder(
                      itemCount: articleCount,
                      itemBuilder: (context, index) {
                        final article = controller.healthArticles[index];
                        return ListTile(
                          onTap: () {
                            Get.to(() => ArticleDetail(article: article));
                          },
                          leading: CircleAvatar(
                            radius: 23,
                            backgroundImage: article.urlToImage != null
                                ? NetworkImage(article.urlToImage!)
                                : const AssetImage('assets/logo.png')
                                    as ImageProvider,
                          ),
                          title: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ));
      }),
    );
  }
}
