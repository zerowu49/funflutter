import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funflutter/provider/news_provider.dart';
import 'package:funflutter/widgets/card_article.dart';
import 'package:funflutter/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          print("loading");
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state.state == ResultState.HasData) {
          print("hasData");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(article: article);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
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
      // iosBuilder: _buildIos,
      iosBuilder: _buildAndroid,
    );
  }
}
