import 'package:flutter/material.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/detail_pages/post_details.dart';
import 'package:flutterapp/services/db_helper.dart';
import 'package:flutterapp/detail_pages/user_details.dart';

class PostsPage extends StatefulWidget {
  final User user;

  const PostsPage({Key key, @required this.user}) : super(key: key);
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  DBhelper dbhelper;
  List<Post> posts;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getPosts();
  }

  Future<List<Post>> getPosts() async {
    posts = await dbhelper.getPostsOfUser(widget.user);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2),
                  height: 100,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostDetails(
                                post: posts[index],
                                user: widget.user,
                              )));
                    },
                    child: Card(
                      color: Colors.purple.shade100,
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserPage(user: widget.user),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                child: Text(
                                  widget.user.id.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                radius: 50,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                posts[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 50,
                              ),
                            ),
                          )
                        ],
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
