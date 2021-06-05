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

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isTagging = false;
  List<PhotoState> photoStates = List.of(urls1.map((url) => PhotoState(url)));

  void toggleTagging(String url) {
    setState(() {
      isTagging = !isTagging;
      photoStates.forEach((element) {
        if (isTagging && element.url == url) {
          element.selected = true;
        } else {
          element.selected = false;
        }
      });
    });
  }

  void onPhotoSelect(String url, bool selected) {
    setState(() {
      photoStates.forEach((element) {
        if (element.url == url) {
          element.selected = selected;
        }
      });
    });
  }

  @override
  Widget build(BuildContext contect) {
    return MaterialApp(
      title: 'Photo Viewer',
      home: GalleryPage(
        title: 'Image Gallery',
        photoStates: photoStates,
        tagging: isTagging,
        toggleTagging: toggleTagging,
        onPhotoSelect: onPhotoSelect,
      ),
    );
  }
}

class PhotoState {
  String url;
  bool selected;

  PhotoState(this.url, {this.selected = false});
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<PhotoState> photoStates;
  final bool tagging;

  final Function toggleTagging;
  final Function onPhotoSelect;

  GalleryPage(
      {this.title,
      this.photoStates,
      this.tagging,
      this.toggleTagging,
      this.onPhotoSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: GridView.count(
        primary: false,
        crossAxisCount: 2,
        children: List.of(photoStates.map((ps) => Photo(
              state: ps,
              selectable: tagging,
              onLongPress: toggleTagging,
              onSelect: onPhotoSelect,
            ))),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  final PhotoState state;
  final bool selectable;
  final Function onLongPress;
  final Function onSelect;

  Photo({this.state, this.selectable, this.onLongPress, this.onSelect});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      GestureDetector(
        child: Image(image: NetworkImage(state.url)),
        onLongPress: () => onLongPress(state.url),
      )
    ];
    if (selectable) {
      children.add(Positioned(
          left: 20,
          top: 0,
          child: Theme(
              data: Theme.of(context)
                  .copyWith(unselectedWidgetColor: Colors.grey[200]),
              child: Checkbox(
                onChanged: (value) {
                  onSelect(state.url, value);
                },
                value: state.selected,
                activeColor: Colors.blue,
                checkColor: Colors.black,
              ))));
    }
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
