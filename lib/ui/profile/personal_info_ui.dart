import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/text_edit_dialog.dart';

class PersonalInfoUI extends StatefulWidget {
  final User user;

  const PersonalInfoUI({Key key, @required this.user}) :
        assert (user != null),
        super(key: key);

  @override
  _PersonalInfoUIState createState() => _PersonalInfoUIState();
}

class _PersonalInfoUIState extends State<PersonalInfoUI> {
  GlobalKey<ScaffoldState> _snackBarScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    bool obscureInfo = User.singleton != null;
    obscureInfo = obscureInfo ? ! User.singleton.canAccessInfo(widget.user) : true;

    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
      child: Scaffold(
        key: _snackBarScaffoldKey,
        body: Scaffold(
            bottomSheet: BottomSheet(
              backgroundColor: Colors.grey.withOpacity(0.2),
              onClosing: () => null,
              builder: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "- ${localizations.getValue('all_info_obscured_message')}.\n"
                          "- ${localizations.getValue('press_item_to_edit')}.",
                      maxLines: null,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            body: CustomScrollView(
              slivers: <Widget>[
                _PersonalInfoSliverAppBar(),

                SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () => _onEditUsername(context),
                      child: Center(
                        child: Text(widget.user.username,
                            style: TextStyle(
                                fontSize: 25
                            )
                        ),
                      ),
                    )
                ),

                SliverToBoxAdapter(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${_getPriorityLabelText(context, obscureInfo)}: "),
                          Text(_getPriorityValueText(context, obscureInfo),
                              style: TextStyle(color: _getPriorityColor())
                          ),
                        ]
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text(localizations.getValue("phone_number")),
                      subtitle: Text(widget.user.phoneNumber),
                      onTap: () => _onEditPhoneNumber(context),
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text(localizations.getValue("address")),
                      subtitle: Text(widget.user.address),
                      onTap: () => _onEditAddress(context),
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text(localizations.getValue("family")),
                      subtitle: Text(widget.user.family.name),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }

  String _getPriorityLabelText(BuildContext context, bool obscured) {
    if(obscured) return ShamLocalizations.of(context).getValue('priority_score_obscured');
    else return ShamLocalizations.of(context).getValue("priority_score");
  }

  String _getPriorityValueText(BuildContext context, bool obscured) {
    if(obscured) return '';
    if (widget.user.isLowPrio) return ShamLocalizations.of(context).getValue("priority_score_low");
    if (widget.user.isMidPrio) return ShamLocalizations.of(context).getValue("priority_score_mid");
    else return ShamLocalizations.of(context).getValue("priority_score_high");
  }

  Color _getPriorityColor() {
    if(User.singleton == null || widget.user.id != User.singleton?.id) return Colors.transparent;
    if (widget.user.isLowPrio) return Colors.red;
    if (widget.user.isMidPrio) return Colors.blue;
    else return Colors.green;
  }

  void _showEmptyTextSnackBar(BuildContext context) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    _snackBarScaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.black,
      content: Text(localizations.getValue('text_is_empty')),
      action: SnackBarAction(
        onPressed: () => _snackBarScaffoldKey.currentState.hideCurrentSnackBar(),
        label: localizations.getValue('hide'),
      ),
    )
    );
  }

  void _onEditUsername(BuildContext context) async {
    String newUsername = await _showEditUsernameDialog(context);

    if(newUsername != null) {
      if (newUsername.isEmpty) _showEmptyTextSnackBar(context);

      else setState(() => widget.user.username = newUsername);
    }
  }

  Future<String> _showEditUsernameDialog(BuildContext context) async {
    return showDialog<String>(
        context: context,
        builder: (context) => TextEditDialog(
          title: ShamLocalizations.of(context).getValue('edit_username'),
          startingText: widget.user.username,
        )
    );
  }

  void _onEditPhoneNumber(BuildContext context) async {
    String newPhoneNumber = await _showEditPhoneDialog(context);
    ShamLocalizations localizations = ShamLocalizations.of(context);

    if(newPhoneNumber != null) {
      if (newPhoneNumber.isEmpty) {
        _snackBarScaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.black,
          content: Text(localizations.getValue('text_is_empty')),
          action: SnackBarAction(
            onPressed: () => _snackBarScaffoldKey.currentState.hideCurrentSnackBar(),
            label: localizations.getValue('hide'),
          ),
        )
        );
      }

      else {
        setState(() => widget.user.phoneNumber = newPhoneNumber);
      }
    }
  }

  Future<String> _showEditPhoneDialog(BuildContext context) async {
    return showDialog<String>(
        context: context,
        builder: (context) => TextEditDialog(
          title: ShamLocalizations.of(context).getValue('edit_phone_number'),
          startingText: widget.user.phoneNumber,
        )
    );
  }

  void _onEditAddress(BuildContext context) async {
    String newAddress = await _showEditAddressDialog(context);

    if(newAddress != null) {
      if(newAddress.isEmpty) _showEmptyTextSnackBar(context);

      else setState(() => widget.user.address = newAddress);
    }
  }

  Future<String> _showEditAddressDialog(BuildContext context) async {
    return showDialog<String>(
        context: context,
        builder: (context) => TextEditDialog(
          title: ShamLocalizations.of(context).getValue("edit_address"),
          startingText: widget.user.address,
          hintText: ShamLocalizations.of(context).getValue("address_hint"),
        )
    );
  }

  void goToFamily() {

  }
}

class _PersonalInfoSliverAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: Text(ShamLocalizations.of(context).getValue("user_profile")),
      pinned: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      flexibleSpace: Consumer<DefaultValues>(
        builder: (context, defaultValues, child) => FlexibleSpaceBar(
          background: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(color: defaultValues.maroon, height: 150),
                  Container(color: Colors.transparent, height: 50,),
                ],
              ),

              SafeArea(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(User.singleton.image),
                  radius: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
