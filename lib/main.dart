import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sham_mobile/bindings/contact_us_bindings.dart';
import 'package:sham_mobile/bindings/family_info_bindings.dart';
import 'package:sham_mobile/controllers/message_controller.dart';
import 'package:sham_mobile/bindings/phone_auth_bindings.dart';

import 'package:sham_mobile/translations/translations.dart';
import 'package:sham_mobile/ui/drawer/about_library_ui.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/ui/drawer/about_app_ui.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/ui/drawer/change_language_dialog.dart';

import 'barrels/main_barrel.dart';
import 'barrels/loading_barrel.dart';
import 'barrels/login_barrel.dart';
import 'ui/user/phone_auth_ui.dart';
import 'controllers/user_controller.dart';
import 'barrels/contact_info_barrel.dart';
import 'barrels/contact_us_barrel.dart';
import 'barrels/family_info_barrel.dart';
import 'barrels/accounting_barrel.dart';

import 'package:sham_mobile/constants/locales.dart';

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
          supportedLocales: supportedLocales,

          debugShowCheckedModeBanner: false,

          onInit: _initializeControllers,

          localizationsDelegates: localizationsDelegates,

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

  static const List<LocalizationsDelegate> localizationsDelegates = const [
      DefaultMaterialLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
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
    GetPage(name: '/user/account_info', page: () => AccountingUI(),binding: AccountingBindings(),),

    // Drawer
    GetPage(name:'/about_app', page: () => AboutAppUI(),),
    GetPage(name:'/contact_us', page: () => ContactUsUI(), binding: ContactUsBindings(),),
    GetPage(name:'/about_library', page: () => AboutLibraryUI(),),
    GetPage(name: '/change_language', page: () => ChangeLanguageDialog(),),

  ];

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
        fontFamily: ksMainFontFamily,

        colorScheme: Theme.of(context).colorScheme.copyWith(primary: kcMaroon,),

        textTheme: TextTheme(
          headline6: TextStyle(fontSize: ktsLargeTextSize),
          subtitle1: TextStyle(fontSize: ktsMediumTextSize), // ListTile title size
          bodyText2: TextStyle(fontSize: ktsSmallTextSize), // ListTile subtitle size
          button: TextStyle(fontSize: ktsSmallTextSize, color: kcMaroon)
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
