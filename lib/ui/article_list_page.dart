import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funflutter/data/api/api_service.dart';
import 'package:funflutter/data/model/article.dart';
import 'package:funflutter/widgets/card_article.dart';
import 'package:funflutter/widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  Widget _buildList(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Refresh Data"),
              onPressed: () {
                print("refresh");
                setState(() {
                  _article = ApiService().topHeadlines();
                });
              },
            ),
            FutureBuilder(
              future: _article,
              builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
                var state = snapshot.connectionState;
                if (state != ConnectionState.done) {
                  print("loading");
                  return Center(
                      child: CircularProgressIndicator(color: Colors.blue));
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.articles.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data?.articles[index];
                        return CardArticle(article: article!);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return Text('');
                  }
                }
              },
            ),
          ],
        ),
      ),
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
