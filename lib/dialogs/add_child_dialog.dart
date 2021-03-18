import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sham_mobile/barrels/family_info_barrel.dart';
import 'package:sham_mobile/models/family_member.dart';
import 'package:sham_mobile/models/gender.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/default_widgets.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/string_helper.dart';
import 'package:sham_mobile/widgets_ui/popup_menu_image_picker.dart';
import 'package:sham_mobile/widgets_ui/round_clipper.dart';
import 'package:sham_mobile/widgets_ui/gender_dropdown_menu.dart';

class AddChildDialog extends StatefulWidget {
  final Child child;

  const AddChildDialog({Key key, this.child = const Child.nonNull()})
      : super(key: key);

  @override
  _AddChildDialogState createState() => _AddChildDialogState();
}

class _AddChildDialogState extends State<AddChildDialog> {
  static final double imageButtonSize = 65;

  static final double defaultFieldHeight = 75;

  DateTime _selectedBirthday;

  String _name;

  Gender _gender;

  File _image;

  @override
  void initState() {
    _name = widget.child.name;
    _selectedBirthday = widget.child.birthday;
    _gender = widget.child.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('add_child'.tr),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _ImageSelectorButton(
              child: _buildImageButtonContent(),
              onImageSelected: _onImageSelected,
              radius: imageButtonSize,
            ),
            verticalHugeSpacer,
            TextField(
              onChanged: (text) => _name = text,
              decoration: InputDecoration(
                labelText: 'full_name'.tr + '*',
                border: OutlineInputBorder(),
              ),
            ),
            verticalHugeSpacer,
            Container(
              padding: EdgeInsets.all(8),
              height: defaultFieldHeight,
              decoration: BoxDecoration(
                borderRadius: kbrDefaultFieldBorderRadius,
                border: kbDefaultFieldBorder,
              ),
              child: Center(
                child: GenderDropdownMenu(
                  noSelectionText: '-- ' + 'gender'.tr + ' --',
                  onGenderChanged: (gender) => setState(() => _gender = gender),
                  currentValue: _gender,
                  isExpanded: true,
                ),
              ),
            ),
            verticalHugeSpacer,
            _BirthdayPickerButton(
              birthdayButtonText: _birthdayButtonText,
              onDateSelected: _onBirthdaySelected,
              height: defaultFieldHeight,
            )
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => _onAddPressed(),
          child: Text('add'.tr),
        ),
        FlatButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        )
      ],
    );
  }

  Widget _buildImageButtonContent() {
    final String childImage = widget.child.image;

    if (_image != null)
      return RoundClipper(
          radius: imageButtonSize * 2,
          child: Image.file(_image, fit: BoxFit.cover));
    else if (childImage.isNotEmpty)
      return RoundClipper(
          radius: imageButtonSize * 2, child: Image.network(childImage));
    else
      return Center(
        child: Icon(
          Icons.portrait,
          size: imageButtonSize,
        ),
      );
  }

  void _onImageSelected(File file) {
    if (file != null) setState(() => _image = file);
  }

  void _onBirthdaySelected(DateTime date) async {
    if (date != null) setState(() => this._selectedBirthday = date);
  }

  String get _birthdayButtonText {
    if (_selectedBirthday != null)
      return StringHelper.dateToString(_selectedBirthday);
    else
      return 'birthday'.tr + '*';
  }

  void _onAddPressed() async {
    Child child = Child(
      name: _name,
      birthday: _selectedBirthday,
      image: _image == null ? '' : _image.path,
    );
    final bool childAdded =
        await Get.find<FamilyInfoController>().addChild(child);
    if (childAdded) Get.back();
  }
}

class _BirthdayPickerButton extends StatelessWidget {
  final String birthdayButtonText;

  final Function(DateTime) onDateSelected;

  final double height;

  const _BirthdayPickerButton({
    Key key,
    @required this.birthdayButtonText,
    @required this.onDateSelected,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          border: kbDefaultFieldBorder,
          borderRadius: kbrDefaultFieldBorderRadius,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.cake_outlined, color: kcMaroon),
            ),
            Text(birthdayButtonText),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) async {
    final DateTime date = await showDatePicker(
      locale: Get.locale,
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      // 20 years ago
      currentDate: DateTime.now(),
      lastDate: DateTime(2020),
    );

    this.onDateSelected(date);
  }
}

class _ImageSelectorButton extends StatelessWidget {
  final double radius;

  final Widget child;

  final Function(File) onImageSelected;

  const _ImageSelectorButton({
    Key key,
    @required this.radius,
    @required this.child,
    @required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kcMaroon,
      foregroundColor: Colors.white,
      radius: radius,
      child: PopupMenuImagePicker(
        cameraOptionText: 'camera'.tr,
        galleryOptionText: 'gallery'.tr,
        onImageSelected: this.onImageSelected,
        child: child,
      ),
    );
  }
}
