import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/blocs/bloc_observer.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/misc/loading_ui.dart';
import 'package:sham_mobile/widgets/default_values.dart';

import 'blocs/dynamic_values/dynamic_values_bloc.dart';

void main(){
  Bloc.observer = ShamBlocObserver();
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

              child: MaterialApp(
                localizationsDelegates: [
                  const ShamLocalizationsDelegate(),
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en'),
                  const Locale('ar')
                ],
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
                home: LoadingUI(),
              )
          ),
        ),
      ),
    );
  }
}
