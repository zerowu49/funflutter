import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funflutter/ArticleDetailPage.dart';
import 'package:funflutter/article.dart';
import 'package:funflutter/widgets/platform_widget.dart';

class ArticleListPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
      builder: (context, snapshot) {
        final List<Article> articles = parseArticles(snapshot.data);
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            var article = articles[index];
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: article.urlToImage,
                  child: Image.network(
                    article.urlToImage,
                    width: 100,
                  ),
                ),
                title: Text(article.title),
                subtitle: Text(article.author),
                onTap: () {
                  Navigator.pushNamed(context, ArticleDetailPage.routeName,
                      arguments: article);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
