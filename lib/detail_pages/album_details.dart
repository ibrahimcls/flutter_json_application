import 'package:flutter/material.dart';
import 'package:flutterapp/models/album.dart';
import 'package:flutterapp/models/photo.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/detail_pages/photo_view.dart';
import 'package:flutterapp/services/db_helper.dart';

class AlbumDetails extends StatefulWidget {
  final Album album;

  const AlbumDetails({Key key, @required this.album}) : super(key: key);
  @override
  _AlbumDetailsState createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  DBhelper dbhelper;
  List<Photo> photos;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getPhotos();
  }

  Future<List<Photo>> getPhotos() async {
    photos = await dbhelper.getPhotosOfAlbum(widget.album);
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album Details"),
      ),
      body: FutureBuilder(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Hero(
                    tag: "${photos[index].url}",
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoView(
                              photo: photos[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple.shade200,
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        photos[index].thumbnailUrl)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
