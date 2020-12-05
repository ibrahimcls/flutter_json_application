import 'package:flutter/material.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/todo.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/detail_pages/post_details.dart';
import 'package:flutterapp/services/db_helper.dart';
import 'package:flutterapp/detail_pages/user_details.dart';

class TodosPage extends StatefulWidget {
  final User user;

  const TodosPage({Key key, @required this.user}) : super(key: key);
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  DBhelper dbhelper;
  List<Todo> todos;
  @override
  void initState() {
    super.initState();
    dbhelper = DBhelper();
    getTodos();
  }

  Future<List<Todo>> getTodos() async {
    todos = await dbhelper.getTodosOfUser(widget.user);
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2),
                  height: 100,
                  child: Card(
                    color: Colors.purple.shade100,
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              todos[index].title,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            trailing: Icon(
                              todos[index].completed == true
                                  ? Icons.assignment_turned_in
                                  : Icons.cancel,
                              size: 50,
                              color: todos[index].completed == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
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
