import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomuser_flutter/states/userState.dart';
import 'package:randomuser_flutter/ui/userDetails.dart';
import '../commonFunctions.dart' as CommonFunctions;
import '../enums.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, _) => Scaffold(
        appBar: AppBar(
          title: Text("Random Users"),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: "Reload",
          child: (userState.state == viewState.IsLoading)
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Icon(Icons.refresh),
          onPressed: () {
            userState.loadData();
          },
        ),
        body: (userState.state == viewState.IsLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: userState.users.length,
                itemBuilder: (context, index) => ListTile(
                  leading: new Hero(
                    tag: "image$index",
                    child: CircleAvatar(
                      backgroundImage:
                          new NetworkImage(userState.users[index].pictureSmall),
                    ),
                  ),
                  title: new Text(
                    userState.users[index].fullName(),
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: new Text(userState.users[index].email),
                  trailing: new SizedBox(
                    height: 20.0,
                    child: new Image.asset(CommonFunctions.menOrWomen(
                        userState.users[index].gender)),
                  ),
                  onTap: () {
                    userState.currentSelected = userState.users[index];
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Details(),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
