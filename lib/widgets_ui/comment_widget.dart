import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/models/comment.dart';


import 'default_values.dart';
import 'package:get/get_utils/get_utils.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(comment.userImage),
                ),

                title: Text(comment.username ?? 'new_user'.tr,
                    style: DefaultValues.commentHeaderTextStyle
                ),

                trailing: comment.rating == null || comment.rating == 0 ? Container(width: 0,)
                    : SizedBox(
                  width: 80,
                  child: RatingBar.builder(
                    initialRating: comment.rating,
                    onRatingUpdate: (value) => null,
                    ignoreGestures: true,
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                    unratedColor: Colors.grey,
                    itemSize: 15,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.only(start: 35),
                child: Text(
                  comment.body,
                  style: DefaultValues.commentTextStyle,
                  maxLines: 20,
                ),
              )
            ]
        );
  }
}
