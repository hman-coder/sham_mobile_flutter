import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/controllers/user_controller.dart';
import 'package:sham_mobile/ui/drawer/change_language_dialog.dart';
import 'package:sham_mobile/constants/paths.dart';

class DrawerUI extends StatefulWidget {
  @override
  _DrawerUIState createState() => _DrawerUIState();
}

class _DrawerUIState extends State<DrawerUI> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('${kpAssetImages}drawer_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
            padding: EdgeInsets.zero, children: _buildAllElements(context)),
      ),
    );
  }

  List<Widget> _buildAllElements(BuildContext context) {
    List<Widget> ret = List()..add(_buildDrawerHeader(context));
    if (Get.find<UserController>() != null) ret.addAll(_buildDrawerUserItems());
    ret.addAll(_buildDrawerGlobalItems());
    return ret;
  }

  Widget _buildDrawerHeader(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              backgroundImage: userController.isUserLoggedIn
                  ? AssetImage(userController.user.image)
                  : AssetImage('${kpAssetImages}profile_picture.png'),
              radius: 35),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: GestureDetector(
              onTap: userController.isUserLoggedIn
                  ? () => Get.toNamed('/login')
                  : null,
              child: Text(
                userController.isUserLoggedIn
                    ? userController.user.fullName
                    : 'create_account'.tr,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Arslan', fontSize: 30),
              ),
            ),
          ),
          Divider(color: Colors.grey)
        ],
      ),
    );
  }

  List<Widget> _buildDrawerUserItems() {
    return <Widget>[
      _buildListTile('contact_info', Icons.person, '/user/contact_info'),
      _buildListTile('family_info', Icons.group, '/user/family_info'),
      _buildListTile('account', Icons.local_atm, '/user/account_info'),
      Divider(color: Colors.grey)
    ];
  }

  List<Widget> _buildDrawerGlobalItems() {
    return <Widget>[
      _buildListTile('about_app', Icons.smartphone, '/about_app'),
      _buildListTile('about_sham', Icons.local_library, '/about_library'),
      _buildListTile('contact_us', Icons.mail, '/contact_us'),
      ListTile(
          onTap: () => Get.dialog(ChangeLanguageDialog()),
          title: Text('change_language'.tr,
              textDirection: Get.direction,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Arslan', fontSize: 28)),
          leading: Icon(Icons.language_outlined, color: Colors.white)),
    ];
  }

  ListTile _buildListTile(String key, IconData icon, String route) {
    return ListTile(
        onTap: () {
          if (route != null) Get.toNamed(route);
        },
        title: Text(key.tr,
            textDirection: Get.direction,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Arslan', fontSize: 28)),
        leading: Icon(icon, color: Colors.white));
  }
}
