import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sham_mobile/bindings/contact_us_bindings.dart';
import 'package:sham_mobile/bindings/family_info_bindings.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/bindings/phone_auth_bindings.dart';

import 'package:sham_mobile/translations/translations.dart';
import 'package:sham_mobile/ui/drawer/about_library_ui.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/ui/drawer/about_app_ui.dart';
import 'package:get/get.dart';

import 'barrels/main_barrel.dart';
import 'barrels/loading_barrel.dart';
import 'barrels/login_barrel.dart';
import 'ui/user/phone_auth_ui.dart';
import 'controllers/user_controller.dart';
import 'barrels/contact_info_barrel.dart';
import 'barrels/contact_us_barrel.dart';
import 'barrels/family_info_barrel.dart';

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
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),

        child: GetMaterialApp(
          supportedLocales: _getSupportedLocales(),

          debugShowCheckedModeBanner: false,
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
  }

  List<LocalizationsDelegate> _getLocalizationsDelegates() => [
      DefaultMaterialLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    ];

  List<Locale> _getSupportedLocales() => [
    const Locale('en'),
    const Locale('ar')
  ];

  List<GetPage> _getPages() => [
    GetPage(name: '/loading', page: () => LoadingUI(), binding: LoadingBindings(),),
    GetPage(name:'/main', page: () => MainUI(), binding: MainBindings(),),

    // login
    GetPage(name:'/login', page: () => LoginUI(), binding: LoginBindings(),),
    GetPage(name:'/phone_auth', page: () => PhoneAuthUI(), binding: PhoneAuthBindings(),),

    // user
    GetPage(name: '/user/contact_info', page: () => ContactInfoUI(), binding: ContactInfoBindings(),),
    GetPage(name:'/user/family_info', page: () => FamilyInfoUI(), binding: FamilyInfoBindings(),),

    // Drawer
    GetPage(name:'/about_app', page: () => AboutAppUI(),),
    GetPage(name:'/contact_us', page: () => ContactUsUI(), binding: ContactUsBindings(),),
    GetPage(name:'/about_library', page: () => AboutLibraryUI(),),
  ];

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
        fontFamily: ksMainFontFamily,

        colorScheme: Theme.of(context).colorScheme.copyWith(primary: kcMaroon,),

        textTheme: TextTheme(
          headline6: TextStyle(fontSize: ktsLargeTextSize),
          subtitle1: TextStyle(fontSize: ktsMediumTextSize), // ListTile title size
          bodyText2: TextStyle(fontSize: ktsSmallTextSize), // ListTile subtitle size
          button: TextStyle(fontSize: ktsSmallTextSize)
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
            headline6: TextStyle(fontSize: ktsExtraLargeTextSize, fontFamily: ksMainFontFamily,),
          ),
          centerTitle: true,
        ),

        primaryColor: kcMaroon,

        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kcMaroon
        )
    );
  }
}
