import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

const List<String> urls1 = [
  "https://searchengineland.com/figz/wp-content/seloads/2016/02/Picture2.png",
  "https://searchengineland.com/figz/wp-content/seloads/2015/07/apps-mobile-smartphone-ss-1920.jpg",
  "https://news.psu.edu/sites/default/files/styles/threshold-992/public/apps-on-phone.jpeg?itok=7grZOXSv",
  "https://mk0buildfireqbf86ll2.kinstacdn.com/wp-content/themes/build_fire/img/new-home-hero.webp",
  "https://assets.entrepreneur.com/content/3x2/2000/20190612193425-GettyImages-1066987316-crop.jpeg?width=700&crop=2:1"
];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext contect) {
    return MaterialApp(
      title: 'Photo Viewer',
      home: GalleryPage(
        title: 'Image Gallery',
        urls: urls1,
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<String> urls;

  GalleryPage({this.title, this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: GridView.count(
        primary: false,
        crossAxisCount: 2,
        children: List.of(urls.map((url) => Photo(url: url))),
      ),
    );
  }
}

class Photo extends StatefulWidget {
  final String url;
  Photo({this.url});

  @override
  PhotoState createState() => PhotoState(url: this.url);
}

class PhotoState extends State<Photo> {
  String url;
  int index = 0;

  PhotoState({this.url});

  onTap() {
    setState(() {
      index >= urls1.length - 1 ? index = 0 : index++;
    });
    url = urls1[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(child: Image.network(url), onTap: onTap),
    );
  }
}
