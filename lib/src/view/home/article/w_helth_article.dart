import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mabook/src/controller/helth_article_controller.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:mabook/src/view/home/article/d_article.dart';
import 'package:mabook/src/view/home/article/helth_article.dart';

class HealthArticlePage extends StatelessWidget {
  final int articleCount;
  const HealthArticlePage({super.key, required this.articleCount});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final HealthArticleController controller =
          Get.put(HealthArticleController());

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Helth article',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.to(
                            () => HelthArticleScreen(
                                articleCount: controller.healthArticles.length),
                            transition: Transition.leftToRight);
                      },
                      child: const Text('See all',
                          style: TextStyle(color: green))),
                ],
              ),
            ),
            controller.healthArticles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                                  : const AssetImage('assets/noImage.jpg')
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
                    ),
                  )
          ],
        ),
      );
    });
  }
}
