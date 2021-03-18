import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/family_info_controller.dart';
import 'package:sham_mobile/models/family_member.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/default_widgets.dart';
import 'package:sham_mobile/widgets_ui/named_avatar.dart';
import 'package:sham_mobile/dialogs/add_child_dialog.dart';

class FamilyInfoUI extends GetView<FamilyInfoController> {
  static final double parentAvatarSize = 55;

  static final double childAvatarSize = 50;

  static final double topSectionHeight = 370;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(    // Fill background with maroon color
            constraints: BoxConstraints.expand(),
            color: kcMaroon,
          ),

          SizedBox(
            height: topSectionHeight,
            child: _buildTopSection(context),
          ),

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
                : ListView(
                    padding: EdgeInsets.only(top: 15),
                    children:
                        _buildChildrenWidgets(controller.children).toList(),
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
        Text(
          controller.familyName,
          style: TextStyle(
            fontSize: ktsExtraLargeTextSize,
            color: Colors.white,
          ),
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
          icon: Icon(Icons.edit, color: Colors.white),
          onPressed: () => null,
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () => _onAddPressed(),
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

    if (children.length % 2 == 0) {
      yield _buildChildrenRow([null]);
      yield verticalSmallSpacer;
    }
  }

  Widget _buildAddChildAvatar() {
    return GestureDetector(
      onTap: () => _onAddPressed(),
      child: NamedAvatar(
        title: 'add_child'.tr,
        titleColor: Colors.black,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, size: childAvatarSize),
        avatarSize: childAvatarSize,
      ),
    );
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

  Widget _buildSingleChildAvatar(FamilyMember child) {
    return NamedAvatar(
      image: NetworkImage(child.image),
      title: child.name,
      subtitle: child.title,
      titleColor: Colors.black,
      subtitleColor: Colors.black87,
      borderColor: Colors.black,
      avatarSize: childAvatarSize,
    );
  }

  void _onAddPressed() {
    Get.dialog(AddChildDialog());
  }
}


