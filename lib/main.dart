import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/error/error_controller.dart';
import 'package:sham_mobile/phone_auth/phone_auth_bindings.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/translations/translations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'dynamic_values/dynamic_values_bloc.dart';
import 'package:get/get.dart';

import 'main/barrel.dart';
import 'loading/barrel.dart';
import 'login/login_barrel.dart';
import 'phone_auth/phone_auth_ui.dart';

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
  return Provider<DynamicValuesBloc>(
      create: (context) => DynamicValuesBloc(),
      child: Provider<DefaultValues>(
        create: (BuildContext context) => DefaultValues(),

        child: Consumer<DefaultValues>(
          builder: (context, defaultValues, _) => GestureDetector(
            // Allows hiding the keyboard when a TextField loses focus
              onTap: () {
                FocusNode currentFocus = FocusScope.of(context);
                if(! currentFocus.hasPrimaryFocus) currentFocus.unfocus();
              },

              child: GetMaterialApp(
                onInit: () {
                  Get.lazyPut(() => ErrorController());
                },
                localizationsDelegates: _getLocalizationsDelegates(),

                translations: ShamTranslations(),

                locale: Locale('ar'),

                // supportedLocales: _getSupportedLocales(),

                getPages: _getPages(),

                initialRoute: '/loading',

                theme: ThemeData(
                    fontFamily: Provider.of<DefaultValues>(context).mainFontFamily,

                    bottomAppBarTheme: BottomAppBarTheme(
                      color: Colors.black,
                    ),

                    tabBarTheme: TabBarTheme.of(context).copyWith(
                      labelColor: Colors.white,
                      unselectedLabelColor: Color(0xffD0D0D0),
                    ),

                    primaryColor: defaultValues.maroon,

                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: defaultValues.maroon
                    )
                ),

                title: 'Sham',
              )
          ),
        ),
      ),
    );
  }

  List<LocalizationsDelegate> _getLocalizationsDelegates() => [
      const ShamLocalizationsDelegate(),
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
    GetPage(name:'/phone_auth', page: () => PhoneAuthUI(), binding: PhoneAuthBindings())
  ];
}
