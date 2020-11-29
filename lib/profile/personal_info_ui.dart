import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/user/user_bloc.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/text_edit_dialog.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

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
    bool obscureInfo = context.bloc<UserBloc>().user.id == null;
    obscureInfo = obscureInfo ? ! context.bloc<UserBloc>().user.canAccessInfo(widget.user) : true;

    return Directionality(
      textDirection: Get.direction,
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
                      "- ${'all_info_obscured_message'.tr}.\n"
                          "- ${'press_item_to_edit'.tr}.",
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
                              style: TextStyle(color: _getPriorityColor(context))
                          ),
                        ]
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text("phone_number".tr),
                      subtitle: Text(widget.user.phoneNumber),
                      onTap: () => _onEditPhoneNumber(context),
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text("address".tr),
                      subtitle: Text(widget.user.address),
                      onTap: () => _onEditAddress(context),
                    )
                ),

                SliverToBoxAdapter(
                    child: obscureInfo ? Container()
                        : ListTile(
                      title: Text("family".tr),
                      // subtitle: Text(widget.user.family.name),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }

  String _getPriorityLabelText(BuildContext context, bool obscured) {
    if(obscured) return 'priority_score_obscured'.tr;
    else return "priority_score".tr;
  }

  String _getPriorityValueText(BuildContext context, bool obscured) {
    if(obscured) return '';
    if (widget.user.isLowPrio) return "priority_score_low".tr;
    if (widget.user.isMidPrio) return "priority_score_mid".tr;
    else return "priority_score_high".tr;
  }

  Color _getPriorityColor(BuildContext context) {
    User user = context.bloc<UserBloc>().user;
    if(user == null || widget.user.id != user.id) return Colors.transparent;
    if (widget.user.isLowPrio) return Colors.red;
    if (widget.user.isMidPrio) return Colors.blue;
    else return Colors.green;
  }

  void _showEmptyTextSnackBar(BuildContext context) {
    _snackBarScaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.black,
      content: Text('text_is_empty'.tr),
      action: SnackBarAction(
        onPressed: () => _snackBarScaffoldKey.currentState.hideCurrentSnackBar(),
        label: 'hide'.tr,
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
          title: 'edit_username'.tr,
          startingText: widget.user.username,
        )
    );
  }

  void _onEditPhoneNumber(BuildContext context) async {
    String newPhoneNumber = await _showEditPhoneDialog(context);

    if(newPhoneNumber != null) {
      if (newPhoneNumber.isEmpty) {
        _snackBarScaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.black,
          content: Text('text_is_empty'.tr),
          action: SnackBarAction(
            onPressed: () => _snackBarScaffoldKey.currentState.hideCurrentSnackBar(),
            label: 'hide'.tr,
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
          title: 'edit_phone_number'.tr,
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
          title: "edit_address".tr,
          startingText: widget.user.address,
          hintText: "address_hint".tr,
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
      title: Text("user_profile".tr),
      pinned: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(color: DefaultValues.maroon, height: 150),
                  Container(color: Colors.transparent, height: 50,),
                ],
              ),

              SafeArea(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(context.bloc<UserBloc>().user.image),
                  radius: 70,
                ),
              ),
            ],
          ),
        ),
    );
  }



}
