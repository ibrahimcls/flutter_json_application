import 'package:flutter/material.dart';
import 'package:flutterapp/pages/home_page.dart';
import 'package:flutterapp/services/db_helper.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  String _userId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (isNumeric(value)) {
                        if (int.parse(value) > 0 && int.parse(value) < 10) {
                          return null;
                        } else
                          return "Please enter a valid user id!";
                      } else
                        return "Geçerli user ıd giriniz!";
                    },
                    onSaved: (value) {
                      _userId = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: "User Id",
                      hintText: "Enter User Id ",
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        DBhelper dbHelper = DBhelper();
                        dbHelper.getUserFromUserId(_userId).then((user) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                user: user,
                              ),
                            ),
                          );
                        });
                      }
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String value) {
    if (value == null) return false;
    return double.parse(value, (e) => null) != null ||
        int.parse(value, onError: (e) => null) != null;
  }
}
