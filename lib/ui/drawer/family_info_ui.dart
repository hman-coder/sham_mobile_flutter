import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/user_controller.dart';
import 'package:sham_mobile/ui/dialogs/family/family_name_dialog.dart';
import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';
import 'package:sham_mobile/models/family_member.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/constants/default_widgets.dart';
import 'package:sham_mobile/ui/widgets/named_avatar.dart';
import 'package:sham_mobile/ui/dialogs/add_child_dialog.dart';
import 'package:sham_mobile/ui/dialogs/family/family_code_dialog.dart';
import 'package:sham_mobile/ui/widgets/activatable_widget.dart';

class FamilyInfoUI extends GetView<FamilyInfoController> {
  static final double topSectionHeight = 370;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcMaroon,
      body: Obx(
        () => ActivatableWidget(
          isActive: !controller.isLoading,
          opacity: 1.0,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: topSectionHeight),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 7.0,
                      spreadRadius: 3.5,
                      offset: Offset(0.0, -2.0),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
              ),
              SizedBox(
                height: topSectionHeight,
                child: Obx(
                  () => controller.hasFamily
                      ? _ParentsWidget()
                      : _buildNoFamilyTopSection(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: topSectionHeight),
                child: Obx(
                  () => controller.hasFamily
                      ? _ChildrenWidget()
                      : _buildNoFamilyBottomSection(),
                ),
              ),
              Obx(() => controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoFamilyTopSection() {
    return Column(
      children: [
        AppBar(
          elevation: 0,
        ),
        verticalHugeSpacer,
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(_userImage),
          radius: 55,
        ),
        Expanded(
          child: Center(
            child: Text(
              'no_family_added_header'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: ktsExtraLargeTextSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String get _userImage => Get.find<UserController>().user.image;

  Widget _buildNoFamilyBottomSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'no_family_added_description'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: ktsLargeTextSize),
          ),
        ),
        verticalLargeSpacer,
        FlatButton(
          child: Text(
            'join_family'.tr,
            style: TextStyle(color: kcMaroon, fontSize: ktsMediumTextSize),
          ),
          onPressed: _onJoinFamilyPressed,
        ),
        verticalSmallSpacer,
        FlatButton(
          child: Text(
            'create_family'.tr,
            style: TextStyle(color: kcMaroon, fontSize: ktsMediumTextSize),
          ),
          onPressed: _onCreateFamilyPressed,
        ),
      ],
    );
  }

  void _onJoinFamilyPressed() {
    Get.dialog(FamilyCodeDialog());
  }

  void _onCreateFamilyPressed() async {
    String name = await Get.dialog(FamilyNameDialog(title: 'create_family'.tr));
    if (name != null) controller.createFamilyFromName(name);
  }
}

class _ParentsWidget extends GetView<FamilyInfoController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(),
        _buildFamilyName(),
        verticalHugeSpacer,
        _buildParentsAvatars(),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.delete, color: Colors.white),
          onPressed: controller.deleteFamily,
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () => _onAddParentPressed(),
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildFamilyName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            controller.familyName,
            style: TextStyle(
              fontSize: ktsExtraLargeTextSize,
              color: Colors.white,
            ),
          ),
        ),
        horizontalSmallSpacer,
        IconButton(
          icon: Icon(Icons.edit_outlined, color: Colors.white),
          onPressed: _onEditFamilyNamePressed,
        ),
      ],
    );
  }

  Widget _buildParentsAvatars() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NamedAvatar(
            image: NetworkImage(controller.parents[0].image),
            title: controller.parents[0].name,
            subtitle: controller.parents[0].title,
            avatarSize: 55,
          ),
          NamedAvatar(
            image: NetworkImage(controller.parents[1].image),
            title: controller.parents[1].name,
            subtitle: controller.parents[1].title,
            avatarSize: 55,
          ),
        ],
      ),
    );
  }

  void _onAddParentPressed() {
    Get.dialog(_AddParentDialog());
  }

  void _onEditFamilyNamePressed() async {
    String name = await Get.dialog(FamilyNameDialog(
      title: 'edit_family'.tr,
    ));
    if (name != null) controller.familyName = name;
  }
}

class _ChildrenWidget extends GetView<FamilyInfoController> {
  static final double childAvatarSize = 50;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 15),
      children: _buildChildrenWidgets(controller.children).toList(),
    );
  }

  Iterable<Widget> _buildChildrenWidgets(List<FamilyMember> children) sync* {
    for (int i = 0; i < children.length; i += 2) {
      FamilyMember firstChild = children[i];
      FamilyMember secondChild =
          i + 1 >= children.length ? null : children[i + 1];
      yield _buildChildrenRow([firstChild, secondChild]);
      yield verticalSmallSpacer;
    }

    // In case [children.length] is even, add a row to have
    // the "add-child" widget.
    if (children.length % 2 == 0) {
      yield _buildChildrenRow([null]);
      yield verticalSmallSpacer;
    }
  }

  Widget _buildChildrenRow(List<FamilyMember> children) {
    return Row(
        children: children
            .map<Widget>(
              (e) => Expanded(
                child: Center(
                  child: e == null
                      ? _buildAddChildAvatar()
                      : _buildSingleChildAvatar(e),
                ),
              ),
            )
            .toList());
  }

  Widget _buildAddChildAvatar() {
    return GestureDetector(
      onTap: () => _onAddChildPressed(),
      child: NamedAvatar(
        title: 'add_child'.tr,
        titleColor: Colors.black,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: childAvatarSize),
        avatarSize: childAvatarSize,
      ),
    );
  }

  Widget _buildSingleChildAvatar(FamilyMember child) {
    bool childHasImage = child.image.isNotEmpty;
    return NamedAvatar(
      image: childHasImage
          ? NetworkImage(child.image)
          : AssetImage('assets/images/profile_picture.png'),
      title: child.name,
      backgroundColor: childHasImage ? Colors.white : Colors.black,
      subtitle: child.title + ' ' + 'years_old'.tr,
      titleColor: Colors.black,
      subtitleColor: Colors.black87,
      borderColor: Colors.black,
      avatarSize: childAvatarSize,
    );
  }

  void _onAddChildPressed() {
    Get.dialog(AddChildDialog());
  }
}

class _AddParentDialog extends StatelessWidget {
  const _AddParentDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('add_parent'.tr),
      content: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('to_add_a_parent'.tr),
            _IndentedText(
              text: '1. ' + 'install_app_for_parent'.tr + '.',
            ),
            _IndentedText(
              text: '2. ' + 'sign_up_for_parent'.tr + '.',
            ),
            _IndentedText(
              text: '3. ' + 'go_to_family_ui_for_parent'.tr + '.',
            ),
            _IndentedText(
              text: '4. ' + 'select_join_family_for_parent'.tr + '.',
            ),
            Flexible(
              child: Wrap(
                children: [
                  _IndentedText(
                    text: '5. ' + 'enter_this_code_for_parent'.tr + ':',
                  ),
                  horizontalSmallSpacer,
                  Text(
                    Get.find<FamilyInfoController>().code,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kcMaroon,
                    ),
                  ),
                ],
              ),
            ),
            _IndentedText(
              text: '6. ' + 'accept_join_request_for_parent'.tr,
            ),
          ],
        ),
      ),
      actions: [
        CancelButton(
          style: TextStyle(),
        )
      ],
    );
  }
}

/// A simple [Text] widget that starts with an indent.
class _IndentedText extends StatelessWidget {
  final String text;

  final double indent;

  const _IndentedText({Key key, @required this.text, this.indent = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: indent),
      child: Text(text),
    );
  }
}
