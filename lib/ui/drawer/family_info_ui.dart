import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';
import 'package:sham_mobile/models/family_member.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/constants/default_widgets.dart';
import 'package:sham_mobile/ui/widgets/named_avatar.dart';
import 'package:sham_mobile/ui/dialogs/add_child_dialog.dart';

class FamilyInfoUI extends GetView<FamilyInfoController> {
  static final double parentAvatarSize = 55;

  static final double childAvatarSize = 50;

  static final double topSectionHeight = 370;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // Fill background with maroon color
            constraints: BoxConstraints.expand(),
            color: kcMaroon,
          ),
          SizedBox(
            height: topSectionHeight,
            child: _buildTopSection(context),
          ),
          // Bottom, white sheet
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
            child: controller.children.isEmpty
                ? Center(
                    child: Text('no_child_added_yet'.tr),
                  )
                : Obx(()=> ListView(
                      padding: EdgeInsets.only(top: 15),
                      children:
                          _buildChildrenWidgets(controller.children).toList(),
                    ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(context),
        Row(
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
        ),
        verticalHugeSpacer,
        Row(
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
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
      backgroundColor: childHasImage ? Colors.white :  Colors.black,
      subtitle: child.title + ' ' + 'years_old'.tr,
      titleColor: Colors.black,
      subtitleColor: Colors.black87,
      borderColor: Colors.black,
      avatarSize: childAvatarSize,
    );
  }

  void _onAddParentPressed() {
    Get.dialog(_AddParentDialog(),);
  }

  void _onAddChildPressed() {
    Get.dialog(AddChildDialog());
  }

  void _onEditFamilyNamePressed() async {
    String newName =
        await Get.dialog(_EditFamilyDialog(familyName: controller.familyName));
    if (newName != null) controller.familyName = newName;
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

class _EditFamilyDialog extends GetView<FamilyInfoController> {
  _EditFamilyDialog({this.familyName = '', Key key}) : super(key: key);

  String familyName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('edit_family'.tr),
      content: TextField(
        controller: TextEditingController(
          text: familyName,
        ),
        onChanged: (text) => this.familyName = text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        CancelButton(),
        FlatButton(
          onPressed: () => Get.back(result: familyName),
          child: Text('confirm'.tr),
        ),
      ],
    );
  }
}
