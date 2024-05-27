import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/model/helth_model.dart';
import 'package:mabook/src/view/const/colors.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;
  const ArticleDetail({super.key, required this.article});

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
            ' details',
            style: GoogleFonts.poppins(color: black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                article.urlToImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 210,
                          width: double.infinity,
                          child: Image.network(article.urlToImage!),
                        ),
                      )
                    : Image.asset('assets/logo.png'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'published: ${article.publishedAt}',
                  style: GoogleFonts.poppins(fontSize: 14, color: grey),
                ),
                Text(
                  'auther: ${article.author}',
                  style: GoogleFonts.poppins(fontSize: 14, color: grey),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  " ${article.content}",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  " ${article.description}",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "To know more about this \n ${article.url}",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}
