import 'package:flutter/material.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:get/utils.dart';
import 'package:sham_mobile/constants/paths.dart';

/// Used in views where there should be lists but there are no items to show.
/// It shows a background, fading image, with a text below it.
class NoItemsToShowUI extends StatelessWidget {
  /// The text to show. If this value is null, then ['no_items_to_show'.tr]
  /// is used.
  final String message;

  /// Image asset path
  final String imagePath;

  NoItemsToShowUI({Key key, this.message, this.imagePath = '${kpAssetImages}sham_logo.png'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Without Row + Expanded the image wouldn't stretch
          Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),

          IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(message ?? 'no_items_to_show'.tr, style: Theme.of(context).textTheme.headline6.copyWith(color: kcMaroon)),
            ),
          )
        ],
      ),
    );
  }
}
