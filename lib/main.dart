import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/bloc_observer.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'dynamic_values/dynamic_values_bloc.dart';
import 'package:get/get.dart';

import 'loading/barrel.dart';

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
//    User.buildTestUser();

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
                localizationsDelegates: _getLocalizationsDelegates(),

                supportedLocales: _getSupportedLocales(),

                getPages: [
                  GetPage(name: '/home', page: () => LoadingUI(), binding: LoadingBindings())
                ],

                initialRoute: '/home',

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
}
