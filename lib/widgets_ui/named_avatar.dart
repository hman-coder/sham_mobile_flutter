import 'package:flutter/material.dart';
import 'package:sham_mobile/widgets_ui/default_widgets.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';

/// A widget that creates an Avatar with a title and a subtitle
///  drawn beneath the avatar
class NamedAvatar extends StatelessWidget {
  final Color borderColor;

  final ImageProvider<Object> image;

  final String title;

  final String subtitle;

  final double avatarSize;

  final double borderWidth;

  final Color titleColor;

  final Color subtitleColor;

  final Color backgroundColor;

  final Widget child;

  const NamedAvatar({
    Key key,
    this.borderColor = Colors.white,
    this.image,
    this.child,
    @required this.title,
    this.avatarSize = 45,
    this.borderWidth = 2,
    this.subtitle,
    this.titleColor = Colors.white,
    this.subtitleColor = Colors.white70,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.circular(avatarSize + 5),
          ),
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            backgroundImage: image,
            radius: avatarSize,
            child: child,
          ),
        ),
        verticalSmallSpacer,
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: DefaultValues.ktsMediumTextSize,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: subtitleColor),
          )
      ],
    );
  }
}