import 'package:flutter/material.dart';
import 'package:flutterapp/models/photo.dart';

class PhotoView extends StatefulWidget {
  final Photo photo;
  const PhotoView({Key key, @required this.photo}) : super(key: key);
  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: "${widget.photo.url}",
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.photo.url)),
            ),
          ),
        ),
      ),
    );
  }
}
