import 'package:flutter/material.dart';
import 'package:flutterapp/models/album.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/detail_pages/album_details.dart';
import 'package:flutterapp/services/db_helper.dart';

class AlbumsPage extends StatefulWidget {
  final User user;

  const AlbumsPage({Key key, @required this.user}) : super(key: key);
  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  DBhelper dbhelper;
  List<Album> albums;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getAlbums();
  }

  Future<List<Album>> getAlbums() async {
    albums = await dbhelper.getAlbumsOfUser(widget.user);
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GridView.builder(
              itemCount: albums.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AlbumDetails(album: albums[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple.shade200,
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            albums[index].title.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }
}
