import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sham_mobile/models/comment.dart';
import 'package:sham_mobile/ui/widgets/comment_widget.dart';
import 'package:sham_mobile/ui/widgets/buttons/single_tap_button.dart';
import 'package:sham_mobile/ui/widgets/linear_gradient_background.dart';
import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/controllers/single_book_controller.dart';

class SingleBookUI extends GetView<SingleBookController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _SingleBookSliverAppBar(),

            _SingleBookInfoSection(),

            _SingleBookSimilarBooksListView(),

            _SingleBookReviewSection(),

            SliverToBoxAdapter(
              child: _buildCommentsLabel()
            ),

            _SingleBookComments(),

          ],
        ),
      ),
    );
  }

  Widget _buildCommentsLabel() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          'comments'.tr,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  void _showReviewDialog() async {
    Comment comment = await Get.dialog(_AddOrUpdateReviewDialog(),);

    print('${comment.body}');

    if (comment != null) {
      comment.userImage = 'assets/images/user_icon.png';
      // context.bloc<ViewBookBloc>().add(AddReviewEvent(comment));
    }
  }
}

class _SingleBookSliverAppBar extends GetView<SingleBookController> {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(automaticallyImplyLeading: false,
        pinned: true,
        elevation: 10.0,
        expandedHeight: 400,
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: Container()
        ),
        flexibleSpace: _buildSliverAppBarFlexibleSpace()
    );
  }

  Widget _buildSliverAppBarFlexibleSpace() {
    return FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 12),
              child: Text(controller.book.title,
                style: ktsSliverAppBarTextStyleWithShadow,
                maxLines: 1,
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.only(start: 12, bottom: 5),
              child: Text(controller.book.authorsAsString,
                style: TextStyle(
                    fontSize: 12
                ),
              ),
            ),

            _buildSliverAppBarActions()
          ],
        ),
        background: LinearGradientBackground(
            color: Colors.black54,
            child: Image.asset(controller.book.image,
              fit: BoxFit.fill ,
            )
        )
    );
  }

  Widget _buildSliverAppBarActions() {
    return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: Colors.white,
                )
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[

              Expanded(
                flex: 60,
                child: IntrinsicHeight(
                  child: FlatButton(
                    color: Colors.white.withOpacity(0.25),
                    child: Text('get_book'.tr + '!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: controller.onReserveBook,
                  ),
                ),
              ),

              VerticalDivider(
                width: 0.5,
                color: Colors.white,
              ),

              Expanded(
                  flex: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: SingleTapButton(
                      child: Obx(() => Icon(
                            controller.book.addedToLibrary ? Icons.playlist_add_check: Icons.playlist_add,
                            color: controller.book.addedToLibrary ? Colors.blue : Colors.white,
                            size: 20,
                          ),
                      ),
                      onTap: () => controller.addToPlayList(),
                    ),
                  ),
              ),

              VerticalDivider(
                width: 0.5,
                color: Colors.white,
              ),

              Expanded(
                  flex: 20,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Icon(Icons.share, color: Colors.white, size: 20,),
                        onTap: () => print("Boookmarked ${controller.book.title}"),
                      ),
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}

class _SingleBookInfoSection extends GetView<SingleBookController> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(),
          elevation: 5,
          child: Column(
            children: <Widget>[
              _buildBookInfoItem('categories'.tr, controller.book.categories),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),

              _buildBookInfoItem('age_groups'.tr, controller.book.ageGroups),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),

              _buildBookInfoItem('special_categories'.tr, controller.book.specialCategories),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBookInfoItem(String header, List items) {
    return ListTile(
      isThreeLine: false,

      title: Text(header,
        style: TextStyle(
            fontSize: 18
        ),
      ),

      subtitle: items.isEmpty ? Text(" -- ") : Row(
          children: items.map<Widget>((e) =>
              Text("${e.toString()}"
              // Make sure the last comma is dropped.
                  "${items.indexOf(e) == items.length-1
                  ? ""
                  : 'comma'.tr} ",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
          ).toList()
      ),
    );
  }
}

class _SingleBookSimilarBooksListView extends GetView<SingleBookController> {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text(
              'similar_books'.tr,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
          ),

          Container(
            height: 175,
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) =>
                  Card(
                    child: Container(
                      width: 100,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          LinearGradientBackground(
                              color: Colors.black54,
                              child: Image.asset(controller.book.image, fit: BoxFit.fill,)
                          ),

                          Text(
                            controller.book.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleBookReviewSection extends GetView<SingleBookController> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'rating'.tr,
                style: TextStyle(fontSize: 18),
              ),
            ),

            Divider(
              height: 0.5,
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: controller.book.rating,
                    onRatingUpdate: (value) => null,
                    allowHalfRating: true,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),

                  VerticalDivider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),

                  Text('${controller.book.rating}/5')
                ],
              ),
            ),

            Divider(
              height: 0.5,
              color: Colors.grey,
            ),

            FlatButton(
                child: Text('press_to_review_book'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 18
                    )
                ),
                onPressed: () => null
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleBookComments extends GetView<SingleBookController> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 20),
      sliver: SliverToBoxAdapter(
          child: Obx(() => controller.isLoadingComments
              ? ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 35, maxWidth: 35),
              child: Center(child: CircularProgressIndicator()))
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.comments.map<Widget>((comment) => CommentWidget(comment: comment)).toList(),
          )
          )
      ),
    );
  }
}

class _AddOrUpdateReviewDialog extends StatefulWidget {
  @override
  _AddOrUpdateReviewDialogState createState() => _AddOrUpdateReviewDialogState();
}

class _AddOrUpdateReviewDialogState extends State<_AddOrUpdateReviewDialog> {
  Comment comment = Comment();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text(
            "enter_review".tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )
        ),

        content: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(12),
                  child: RatingBar.builder(
                    initialRating: comment.rating ?? 0,
                    onRatingUpdate: (value) => setState(() => comment.rating = value),
                    itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                  ),
                ),

                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (text) => comment.body = text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                      )
                  ),
                )
              ]
          ),
        ),

        actions: <Widget>[
          CancelButton(),

          FlatButton(
            child: Text("submit".tr),
            onPressed: () => Get.back(result: comment),
          )
        ],
      ),
    );
  }
}


