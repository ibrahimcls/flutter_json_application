import 'package:flutter/material.dart';
import 'package:flutterapp/detail_pages/user_details.dart';
import 'package:flutterapp/models/comment.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/db_helper.dart';

class PostDetails extends StatefulWidget {
  final Post post;
  final User user;

  const PostDetails({Key key, @required this.post, @required this.user})
      : super(key: key);
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  DBhelper dbhelper;
  List<Comment> comments;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getComments();
  }

  Future<List<Comment>> getComments() async {
    comments = await dbhelper.getCommentsOfPosts(widget.post);
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
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
                                radius: 20,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.user.username,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          widget.user.name,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.account_circle)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.post.body,
                          maxLines: 5,
                          style:
                              TextStyle(fontFamily: 'elyazisi', fontSize: 15),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: getComments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comments[index].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  comments[index].email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(comments[index].body),
                              ],
                            ),
                          )),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
