import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/about/about_app_ui.dart';
import 'package:sham_mobile/ui/about/about_library_ui.dart';
import 'package:sham_mobile/ui/about/contact_us_ui.dart';
import 'package:sham_mobile/ui/profile/account_info_ui.dart';
import 'package:sham_mobile/ui/profile/family_info_ui.dart';
import 'package:sham_mobile/ui/profile/personal_info_ui.dart';

class DrawerUI extends StatefulWidget{
  @override
  _DrawerUIState createState() => _DrawerUIState();
}

class _DrawerUIState extends State<DrawerUI> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/drawer_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
            padding: EdgeInsets.zero,
            children: _buildAllElements(context)
        ),
      ),
    );
  }

  List<Widget> _buildAllElements(BuildContext context){
    List<Widget> ret = List()..add(_buildDrawerHeader(context));
    if (User.singleton != null) ret.addAll(_buildDrawerUserItems(context));
    ret.addAll(_buildDrawerGlobalItems(context));
    return ret;
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
                backgroundImage: User.singleton != null ?
                AssetImage(User.singleton.image) :
                AssetImage('assets/images/profile_picture.png'),
                radius: 35
            ),
            Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                child: GestureDetector(
                    onTap: User.singleton == null ? null // TODO: ADD LISTENER TO CREATE ACCOUNT
                        : null,
                    child: Text(User.singleton != null ? User.singleton.username :
                    ShamLocalizations.of(context).getValue('create_account'),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Arslan',
                          fontSize: 30
                      ),
                    )
                )
            ),
            Divider(
                color: Colors.grey
            )
          ],
        )
    );
  }

  List<Widget> _buildDrawerUserItems(BuildContext context) {
    return <Widget>[
      _buildListTile(context, 'personal_info', Icons.person, PersonalInfoUI(user: User.singleton)),
      _buildListTile(context, 'family_info', Icons.group, FamilyInfoUI()),
      _buildListTile(context, 'account', Icons.local_atm, AccountInfoUI()),
      Divider(
          color: Colors.grey
      )
    ];
  }

  List<Widget> _buildDrawerGlobalItems(BuildContext context) {
    return <Widget>[
      _buildListTile(context, 'about_app', Icons.smartphone, AboutAppUI()),
      _buildListTile(context, 'about_sham', Icons.local_library, AboutLibraryUI()),
      _buildListTile(context, 'contact_us', Icons.mail, ContactUsUI()),
      _buildListTile(context, 'change_language', Icons.language, null),
    ];
  }

  ListTile _buildListTile(BuildContext context, String key, IconData icon, Widget route) {
    return ListTile(
        onTap: () {
          if(route != null)
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => route));
        },
        title: Text(ShamLocalizations.of(context).getValue(key),
            textDirection: ShamLocalizations.of(context).getDirection(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Arslan',
                fontSize: 28
            )
        ),
        leading: Icon(icon, color: Colors.white)
    );
  }
}