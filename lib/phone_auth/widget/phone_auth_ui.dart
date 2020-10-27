import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/phone_auth/bloc/phone_auth_bloc_barrel.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/phone_auth/bloc/phone_auth_bloc_barrel.dart';

class PhoneAuthUI extends StatefulWidget {
  @override
  _PhoneAuthUIState createState() => _PhoneAuthUIState();
}

class _PhoneAuthUIState extends State<PhoneAuthUI> {
  bool codeSent = false;
  String verificationId;
  String smsCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneAuthBloc>(
      create: (context) => PhoneAuthBloc(),
      child: Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(ShamLocalizations.of(context).getValue('phone_number_authentication'))
          ),

          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                      ShamLocalizations.of(context).getValue('please_enter_phone_number'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: Provider.of<DefaultValues>(context).extraLargeTextSize,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                      ShamLocalizations.of(context).getValue('please_enter_phone_number_guide') + ".",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: Provider.of<DefaultValues>(context).mediumTextSize
                      )
                  ),
                ),

                SizedBox(height: 40,),

                Center(child: _PhoneNumberField()),

                SizedBox(height: 30,),

                Center(child: _PhoneAuthSubmitButton()),

                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                    builder: (context, state) => (state is SendingCodeState)
                        ? Center(child: SizedBox(height: 35, child: CircularProgressIndicator()))
                        : Container(),
                  ),
                ),

                Center(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                      builder: (context, state) => ! (state is SendingCodeState)
                          ? Container()
                          : Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              ShamLocalizations.of(context).getValue('a_text_will_be_sent'),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: Provider.of<DefaultValues>(context).mediumTextSize
                              )
                          ),
                        ),
                    ),
                  ),
                ),

                BlocListener<PhoneAuthBloc, PhoneAuthState>(
                    listenWhen: (previous, current) =>(
                        current is EmptyPhoneNumberState ||
                        current is NetworkErrorState ||
                        current is UnknownErrorState ||
                        current is CodeSentState
                    ),
                    listener: listenToBlocStates,
                    child: Container()),
              ],
            ),
        ),
      ),
    );
  }

  void listenToBlocStates(BuildContext context, PhoneAuthState state) {
    if(state is CodeSentState)
      _showCodeDialog(context);

    else
      Scaffold.of(context).showSnackBar(_buildSnackBarBasedOnState(context, state));
  }

  void _showCodeDialog(BuildContext context) {
    showDialog(
      context: context,
        barrierDismissible: false,
      builder: (ctx) => BlocProvider<PhoneAuthBloc>.value(
        value: context.bloc<PhoneAuthBloc>(),
        child: _PinCodeDialog()
      )
    );
  }

  SnackBar _buildSnackBarBasedOnState(BuildContext context, PhoneAuthState state) {
    String messageLocalizationKey = 'done';
    if(state is EmptyPhoneNumberState)
      messageLocalizationKey = 'provide_valid_number' ;
    else if (state is NetworkErrorState)
      messageLocalizationKey = 'error_network';
    else if (state is UnknownErrorState)
      messageLocalizationKey = 'error_unknown';

    return SnackBar(
      content: Text(ShamLocalizations.of(context).getValue(messageLocalizationKey)),
      action: SnackBarAction(
        label: ShamLocalizations.of(context).getValue('done'),
        onPressed: Scaffold.of(context).hideCurrentSnackBar,
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CountryPickerButton(),

            SizedBox(width: 10,),

            Container(
              constraints: BoxConstraints(maxWidth: 200),
              color: Colors.grey.shade200,
              child: TextField(
                  decoration: InputDecoration(
                    hintText: ShamLocalizations.of(context).getValue('phone_number'),
                    contentPadding: EdgeInsetsDirectional.only(start: 12),
                  ),
                  style: TextStyle(
                      fontSize: Provider.of<DefaultValues>(context).mediumTextSize
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (text) => context.bloc<PhoneAuthBloc>().add(PhoneNumberChangedEvent(text))
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        Country country = context.bloc<PhoneAuthBloc>().selectedCountry;
        return Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: FlatButton.icon(
            color: Colors.grey.shade200,
              padding: EdgeInsets.all(8),
              onPressed: () => _showCountryPickerDialog(context),
              icon: CountryPickerUtils.getDefaultFlagImage(country),
              label: Text('+${country.phoneCode}',
                style: TextStyle(fontSize: Provider
                    .of<DefaultValues>(context)
                    .mediumTextSize),
              )
          ),
        );
      }
    );
  }

  void _showCountryPickerDialog(BuildContext context) async{
    bool validated = await showDialog<bool>(
        context: context,
        builder: (ctx) => CountryPickerDialog(
            onValuePicked: (country) =>
                context.bloc<PhoneAuthBloc>().add(CountrySelectedEvent(country)),
            title: Text(ShamLocalizations.of(context).getValue('select_country')),
            isSearchable: true,
            itemBuilder: (country) => _CountryDialogListItem(country),
        )
    );

    // TODO: MOVE TO NEXT WIDGET
    if(validated) Navigator.push(context, null);

  }

  bool _shouldRebuild(PhoneAuthState prev, PhoneAuthState curr) {
    return (curr is CountryChangedState) || (curr is InitialState);
  }
}

class _CountryDialogListItem extends StatelessWidget {
  final Country country;

  const _CountryDialogListItem(this.country, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 1
                )
            ),
            child: CountryPickerUtils.getDefaultFlagImage(country)),
        SizedBox(width: 15),
        SizedBox(width: 50, child: Text('+${country.phoneCode}')),
        Flexible(child: Text(country.name, maxLines: 2,))
      ],
    );
  }
}

class _PhoneAuthSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.white.withOpacity(0.5),
      height: 40,
      minWidth: MediaQuery.of(context).size.width - 50,
      child: Text(
        ShamLocalizations.of(context).getValue('verify_number'),
        style: TextStyle(
            color: Colors.white,
            fontSize: Provider.of<DefaultValues>(context).largeTextSize
        ),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        context.bloc<PhoneAuthBloc>().add(PhoneNumberSubmittedEvent());
      },
      color: Provider.of<DefaultValues>(context).maroon,
    );
  }
}

class _PinCodeDialog extends StatelessWidget {
  String _pinCode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listenWhen: (previous, current) => current is CodeValidatedState,
      listener: (ctx, state) => Navigator.pop(context, true),
      child: Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(ShamLocalizations.of(context).getValue('enter_phone_auth_pin_code'),
                          style: TextStyle(fontSize: Provider.of<DefaultValues>(context).mediumTextSize)
                      ),

                      SizedBox(height: 20,),

                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: _PinCodeField(
                            onCodeChanged: (code) => _pinCode = code,
                          )
                      ),

                      SizedBox(height: 10,),

                      BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                          builder: (context, state) {
                            if(state is ValidatingCodeState)
                              return Center(child: CircularProgressIndicator());

                            else if (state is InvalidCodeState)
                              return Center(child: Text(
                                ShamLocalizations.of(context).getValue('invalid_code') + '.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Provider.of<DefaultValues>(context).mediumTextSize
                                )
                              ));

                            else return Container();
                          },
                      ),

                      BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                      builder: (context, state) {
                        if(state is ValidatingCodeState || state is InvalidCodeState)
                          return SizedBox(height: 10);
                        else return Container();
                      }
                      ),

                      FlatButton(
                        minWidth: double.infinity,
                        child: Text(
                          ShamLocalizations.of(context).getValue('confirm'),
                          style: TextStyle(
                            fontSize: Provider.of<DefaultValues>(context).mediumTextSize,
                            color: Colors.white
                          ),
                        ),
                        color: Provider.of<DefaultValues>(context).maroon,
                        onPressed: () => context.bloc<PhoneAuthBloc>().add(CodeSubmittedEvent(_pinCode)),
                      ),

                      FlatButton(
                        minWidth: double.infinity,
                        child: Text(
                          ShamLocalizations.of(context).getValue('cancel'),
                          style: TextStyle(
                            fontSize: Provider.of<DefaultValues>(context).mediumTextSize,
                            color: Provider.of<DefaultValues>(context).maroon
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                ]
          ),
              ),
            )
        ),
      ),
    );
  }
}


class _PinCodeField extends StatelessWidget {
  final Function(String) onCodeChanged;

  const _PinCodeField({Key key, @required this.onCodeChanged}) :
        assert (onCodeChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      onChanged: onCodeChanged,
      keyboardType: TextInputType.number,
      backgroundColor: Colors.transparent,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(8),
        shape: PinCodeFieldShape.box
      ),
      length: 6,
      appContext: context,

    );
  }
}