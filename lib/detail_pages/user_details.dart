import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  child: Text(
                    user.id.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  radius: 50,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 15,
                ),
                Text(
                  user.name +
                      "\n" +
                      user.username +
                      "\n" +
                      user.phone +
                      "\n" +
                      user.website,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Divider(
                  thickness: 15,
                ),
                Text(
                  "Adress",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 15,
                ),
                Text(
                  user.address.city +
                      "\n" +
                      user.address.zipcode +
                      "\n" +
                      user.address.street +
                      "\n" +
                      user.address.suite,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Divider(
                  thickness: 15,
                ),
                Text(
                  "Company",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 15,
                ),
                Text(
                  user.company.name +
                      "\n" +
                      user.company.catchPhrase +
                      "\n" +
                      user.company.bs,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Divider(
                  thickness: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
