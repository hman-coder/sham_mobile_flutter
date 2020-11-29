import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/error/error_controller.dart';
import 'package:sham_mobile/phone_auth/phone_auth_bindings.dart';

import 'package:sham_mobile/translations/translations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'dynamic_values/dynamic_values_bloc.dart';
import 'package:get/get.dart';

import 'main/main_barrel.dart';
import 'loading/loading_barrel.dart';
import 'login/login_barrel.dart';
import 'phone_auth/phone_auth_ui.dart';
import 'user/user_controller.dart';
import 'contact_info/contact_info_barrel.dart';

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

          theme: ThemeData(
              fontFamily: DefaultValues.mainFontFamily,

              bottomAppBarTheme: BottomAppBarTheme(
                color: Colors.black,
              ),

              tabBarTheme: TabBarTheme.of(context).copyWith(
                labelColor: Colors.white,
                unselectedLabelColor: Color(0xffD0D0D0),
              ),

              primaryColor: DefaultValues.maroon,

              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: DefaultValues.maroon
              )
          ),

          title: 'Sham',
        )
    );
  }

  _initializeControllers () {
    Get.lazyPut(() => ErrorController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => DefaultValues());
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
    GetPage(name: '/loading', page: () => LoadingUI(), binding: LoadingBindings()),
    GetPage(name:'/main', page: () => MainUI(), binding: MainBindings()),
    GetPage(name:'/login', page: () => LoginUI(), binding: LoginBindings()),
    GetPage(name:'/phone_auth', page: () => PhoneAuthUI(), binding: PhoneAuthBindings()),
    GetPage(name: '/contact_info', page: () => ContactInfoUI(), binding: ContactInfoBindings()),
  ];
}
