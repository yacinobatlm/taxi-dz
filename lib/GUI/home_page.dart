import 'package:flutter/material.dart';
import 'sign_up_page.dart';

class HomePage extends StatefulWidget {
  final UserDetails detailsUser;

  HomePage({Key key, @required this.detailsUser}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _accountName = "User Name"; // remplace ca avec detailsUser.name
  String _accountEmail = "username@example.com"; // remplace ca avec detailsUser.email
  String _urlAccountImage = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            _accountName,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                          accountEmail: Text(
                            _accountEmail,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                          decoration: BoxDecoration(color: Colors.grey[600]),
                          //currentAccountPicture: NetworkImage(_urlAccountImage),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(
                                _accountName.substring(0, 1).toUpperCase()),
                            radius: MediaQuery.of(context).size.width * 0.01,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            //top: 5,
                            right: MediaQuery.of(context).size.width * 0.01,
                            left: MediaQuery.of(context).size.width * 0.01,
                          ),
                          child: Column(
                            children: <Widget>[
                              _getListTitleDrawer("My Courses", Colors.black,
                                  Icons.local_taxi, () {}),
                              _getListTitleDrawer("Notifications", Colors.black,
                                  Icons.notifications_none, () {}),
                              Divider(
                                color: Colors.black,
                                height: 10,
                              ),
                              _getListTitleDrawer("Add your friends",
                                  Colors.black, Icons.group_add, () {}),
                              _getListTitleDrawer("Help", Colors.black,
                                  Icons.info_outline, () {}),
                              Divider(
                                color: Colors.black,
                                height: 10,
                              ),
                              _getListTitleDrawer("Settings", Colors.black,
                                  Icons.settings, () {}),
                              _getListTitleDrawer("Logout", Colors.black,
                                  Icons.exit_to_app, () {}),
                              Divider(
                                color: Colors.black,
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Conditions d\'utilisation',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                          Text(
                            'v1.0.0',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            // Map widget

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: <Widget>[
                      GetButtonDrawer(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 25),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: <Widget>[
                      buildTextFormFieldSearch(),
                      SizedBox(height: 10,),
                      buildTextFormFieldSearch()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottom: false,
    );
  }

  TextFormField buildTextFormFieldSearch() {
    return TextFormField(
                      //focusNode: focus,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        counterText: "",
                      ),
                      textInputAction: TextInputAction.next,
                      //onFieldSubmitted: function,
                      //validator: function,
                    );
  }

  Widget _getListTitleDrawer(
      String title, Color fontColor, IconData iconTitle, Function onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: fontColor),
      ),
      leading: Icon(
        iconTitle,
        color: Colors.black,
        size: MediaQuery.of(context).size.width * 0.06,
      ),
      onTap: onTap,
    );
  }
}

class GetButtonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Icon(
        Icons.list,
        size: 30,
      ),
    );
  }
}


class TextFormFieldSearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //focusNode: focus,
      style: TextStyle(fontSize: 22),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textInputAction: TextInputAction.search,
      onTap: (){

      },
      //onFieldSubmitted: function,
      //validator: function,
    );
  }
}
