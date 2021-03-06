import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/bindings/phone_auth_bindings.dart';

import 'package:sham_mobile/translations/translations.dart';
import 'package:sham_mobile/ui_temp/about_app_ui.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:get/get.dart';

import 'barrels/main_barrel.dart';
import 'barrels/loading_barrel.dart';
import 'barrels/login_barrel.dart';
import 'ui/phone_auth_ui.dart';
import 'controllers/user_controller.dart';
import 'barrels/contact_info_barrel.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(Sham());
  });
}

class Sham extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
      // Allows hiding the keyboard when a TextField loses focus
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if(! currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },

        child: GetMaterialApp(
          onInit: _initializeControllers,

          localizationsDelegates: _getLocalizationsDelegates(),

          translations: ShamTranslations(),

          locale: Locale('ar'),

          // supportedLocales: _getSupportedLocales(),

          getPages: _getPages(),

          initialRoute: '/loading',


          theme: _buildTheme(context),
          title: 'Sham',
        )
    );
  }

  _initializeControllers () {
    Get.put(ShamMessageController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(DefaultValues(), permanent: true);
  }

  List<LocalizationsDelegate> _getLocalizationsDelegates() => [
      DefaultMaterialLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ];

  List<Locale> _getSupportedLocales() => [
    const Locale('en'),
    const Locale('ar')
  ];

  List<GetPage> _getPages() => [
    GetPage(name: '/loading', page: () => LoadingUI(), binding: LoadingBindings(),),
    GetPage(name:'/main', page: () => MainUI(), binding: MainBindings(),),
    GetPage(name:'/login', page: () => LoginUI(), binding: LoginBindings(),),
    GetPage(name:'/phone_auth', page: () => PhoneAuthUI(), binding: PhoneAuthBindings(),),
    GetPage(name: '/user/contact_info', page: () => ContactInfoUI(), binding: ContactInfoBindings(),),

    // Drawer
    GetPage(name:'/about_app', page: () => AboutAppUI(),),
  ];

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
        fontFamily: DefaultValues.mainFontFamily,

        textTheme: TextTheme(
          headline6: TextStyle(fontSize: DefaultValues.largeTextSize),
          subtitle1: TextStyle(fontSize: DefaultValues.mediumTextSize), // ListTile title size
          bodyText2: TextStyle(fontSize: DefaultValues.smallTextSize), // ListTile subtitle size
        ),

        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black,
        ),

        tabBarTheme: TabBarTheme.of(context).copyWith(
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xffD0D0D0),
        ),

        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: DefaultValues.extraLargeTextSize, fontFamily: DefaultValues.mainFontFamily,),
          ),
          centerTitle: true,
        ),

        primaryColor: DefaultValues.maroon,

        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: DefaultValues.maroon
        )
    );
  }
}
