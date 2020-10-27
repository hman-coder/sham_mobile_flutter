import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/loading/bloc/loading_bloc_barrel.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'file:///E:/Prog/Flutter/sham_mobile/lib/phone_auth/widget/phone_auth_ui.dart';
import 'file:///E:/Prog/Flutter/sham_mobile/lib/main/widget/main_ui.dart';

class LoadingUI extends StatelessWidget {
  final LoadingBloc _bloc;

  LoadingUI({Key key}) : _bloc = LoadingBloc(), super(key: key) {
    _bloc.add(LoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuthUI())));
    return Directionality(
            textDirection: ShamLocalizations.of(context).getDirection(),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: Text(ShamLocalizations.of(context).getValue('title')),
                  centerTitle: true,
                ),
                body: _buildBody(context)
            ),
          );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainUI())),
        child:  _buildMainComponents()
    );
  }

  Column _buildMainComponents() {
    String loading = "يتم التحميل...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 50,
          child: Hero(
            tag: "sham_logo",
            child: Image.asset('assets/images/sham_logo.png',
                fit: BoxFit.cover),
          ),
        ),
        Expanded(flex: 5, child: Container()),
        Expanded(flex: 25, child:_buildQuoteCard()), // Quotes
        Expanded(flex: 5, child: Container()),

        CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: Colors.white,
        ),

        Expanded(flex: 3, child: Container()),
        Expanded(
          flex: 12,
          child: AutoSizeText(loading,
            minFontSize: 22,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuoteCard() {
    String quote = "\"أجمل ما في الماضي أنه قد مضى\"";
    String source = "أوسكار وايلد - صورة دوريان غراي";
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: FittedBox(
                  fit: BoxFit.fitWidth,alignment: Alignment.center,
                  child: AutoSizeText(quote,
                      maxLines: 2,
                      softWrap: true,
                      maxFontSize: 36,
                      minFontSize: 26,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Harmattan',
                      )
                  ),
                ),
              ),
              Center(
                child: AutoSizeText(source,
                    minFontSize: 20,
                    maxFontSize: 40,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Harmattan',
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
}