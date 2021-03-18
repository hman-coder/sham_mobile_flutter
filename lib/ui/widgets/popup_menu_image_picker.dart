import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// A widget that allows the user to choose an image
/// either from a file or a camera.
class PopupMenuImagePicker extends StatelessWidget {
  /// The appearance of the button. Defaults to Icon(Icons.image_outlined)
  final Widget child;

  final ImagePicker _imagePicker = ImagePicker();

  final Function(File) onImageSelected;

  final String cameraOptionText;

  final String galleryOptionText;

  PopupMenuImagePicker({
    Key key,
    this.child,
    @required this.onImageSelected,
    @required this.cameraOptionText,
    @required this.galleryOptionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ImageSource>(
      child: child ?? Icon(Icons.image_outlined),
      onSelected: _onMenuItemSelected,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<ImageSource>(
          value: ImageSource.camera,
          child: Text(cameraOptionText),
        ),
        PopupMenuItem<ImageSource>(
          value: ImageSource.gallery,
          child: Text(galleryOptionText),
        ),
      ],
    );
  }

  void _onMenuItemSelected(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    final File file = pickedFile != null ? File(pickedFile.path) : null;
    this.onImageSelected(file);
  }
}
