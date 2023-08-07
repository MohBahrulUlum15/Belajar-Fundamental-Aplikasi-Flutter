import 'package:dicoding_news_app/data/models/article.dart';
import 'package:flutter/material.dart';

import 'article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(article.urlToImage),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text('Date: ${article.publishedAt}'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Author: ${article.author}'),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName, arguments: article.url);
                    },
                    child: const Text('Read more'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}