import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/dynamic_values/dynamic_values_bloc.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/comment.dart';
import 'package:sham_mobile/user/user_bloc.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/view_book/bloc/view_book_bloc_barrel.dart';
import 'package:sham_mobile/widgets/linear_gradient_background.dart';
import 'package:sham_mobile/widgets/cancel_button.dart';
import 'package:sham_mobile/widgets/comment_widget.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/exception_widget.dart';
import 'package:sham_mobile/widgets/sign_up_alert_dialog.dart';
import 'package:get/get_utils/get_utils.dart';

class ViewBookUI extends StatefulWidget {
  final Book book;

  const ViewBookUI({Key key, this.book}) : super(key: key);

  @override
  _ViewBookUIState createState() => _ViewBookUIState();
}

class _ViewBookUIState extends State<ViewBookUI> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewBookBloc>(
      create: (context) => ViewBookBloc(widget.book),
      child: Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              _ViewBookSliverAppBar(book: widget.book),

              _buildInfoSection(context),

              _buildSimilarBooksListView(context),

              _buildReviewSection(context),

              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'comments'.tr,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),

              _buildComments(context),

              SliverToBoxAdapter(
                  child: BlocBuilder<ViewBookBloc, ViewBookState>(
                    builder: (context, state) => state is LoadingCommentsState
                        ? CircularProgressIndicator()
                        : Container(height: 20),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(),
          elevation: 5,
          child: Column(
            children: <Widget>[
              _buildBookInfoItem(context, 'categories'.tr, widget.book.categories),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),

              _buildBookInfoItem(context, 'age_groups'.tr, widget.book.ageGroups),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),

              _buildBookInfoItem(context, 'special_categories'.tr, widget.book.specialCategories),

              Divider(
                height: 0.5,
                color: Colors.grey,
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBookInfoItem(BuildContext context, String header, List items) {
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

  Widget _buildSimilarBooksListView(BuildContext context) {
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
                              child: Image.asset(widget.book.image, fit: BoxFit.fill,)
                          ),

                          Text(
                            widget.book.title,
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

  Widget _buildReviewSection(BuildContext context) {
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
                  RatingBar(
                    ignoreGestures: true,
                    initialRating: widget.book.rating[0],
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

                  Text('${widget.book.rating[0]}/5')
                ],
              ),
            ),

            Divider(
              height: 0.5,
              color: Colors.grey,
            ),

            Consumer<ViewBookBloc>(
              builder: (context, value, child) => FlatButton(
                  child: Text('press_to_reivew_book'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18
                      )
                  ),
                  onPressed: () => _showReviewDialog(context)
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildComments(BuildContext context) {
    return BlocBuilder<ViewBookBloc, ViewBookState>(
        buildWhen: (previous, current) => current is CommentsLoadedState,
        builder: (context, state) {
          if(state is CommentsLoadedState) {
            // Include dividers in child count except for the last one
            int childCount = state.comments.length * 2 - 1;
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                    (index % 2 == 1) // isDivider
                        ? Divider()

                        : CommentWidget(
                        comment: state.comments[(index / 2).floor()]),

                    // Include dividers in childCount.
                    childCount: childCount
                )
            );
          }
          return SliverToBoxAdapter(child: ExceptionWidget(text: 'error_building_ui'.tr,));
        }
    );
  }

  void _showReviewDialog(BuildContext context) async {
    Comment comment = await showDialog<Comment>(
      context: context,
      builder: (context) => _AddOrUpdateReviewDialog(),
    );

    print('${comment.body}');

    if (comment != null) {
      comment.userImage = 'assets/images/user_icon.png';
      context.bloc<ViewBookBloc>().add(AddReviewEvent(comment));
    }
  }

}

class _ViewBookSliverAppBar extends StatelessWidget {
  final Book book;

  const _ViewBookSliverAppBar({Key key, @required this.book}) : super(key: key);

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
        flexibleSpace: _buildSliverAppBarFlexibleSpace(context)
    );
  }

  Widget _buildSliverAppBarFlexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Consumer<DefaultValues>(
          builder: (context, defaultValues, child) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 12),
                    child: Text(book.title,
                      style: defaultValues.sliverAppBarTextStyleWithShadow,
                      maxLines: 1,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 12, bottom: 5),
                    child: Text(book.authorsAsString,
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ),

                  _buildSliverAppBarActions(context)
                ],
              ),
        ),
        background: LinearGradientBackground(
            color: Colors.black54,
            child: Image.asset(book.image,
              fit: BoxFit.fill ,
            )
        )
    );
  }

  Widget _buildSliverAppBarActions(BuildContext context) {
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 60,
              child: Container(
                color: Colors.white.withOpacity(0.25),
                child: FlatButton(
                  child: Text('get_book'.tr + '!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _showGetBook(context),
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
                  child: ChangeNotifierProvider<Book>.value(
                    value: book,
                    child: Consumer<Book>(
                      builder: (context, book, child) => IconButton(
                        icon: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: Icon(
                              book.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                              color: book.bookmarked ? Colors.amber : Colors.white,
                              size: 20,
                              key: UniqueKey(),
                            )
                        ),
                        onPressed: () => book.bookmarked = ! book.bookmarked,
                      ),
                    ),
                  ),
                )
            ),

            VerticalDivider(
              width: 0.5,
              color: Colors.white,
            ),

            Expanded(
                flex: 20,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.share, color: Colors.white, size: 20,),
                    onPressed: () => print("Boookmarked ${book.title}"),
                  ),
                )
            )
          ],
        )
    );
  }

  void _showGetBook(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
        context.bloc<UserBloc>().user.id == null
            ? SignUpAlertDialog()
            : _GetBookAlertDialog(book: book)
    );
  }
}

class _GetBookAlertDialog extends StatelessWidget {
  final Book book;

  const _GetBookAlertDialog({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DynamicValuesBloc dynamicValues = Provider.of<DynamicValuesBloc>(context, listen: false);

    return Directionality(
      textDirection: ShamLocalizations.of(context).getDirection(),
      child: AlertDialog(
        title: Text(
          "get_book".tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: Text(dynamicValues.getReserveBookMessage(context, book.price),
          maxLines: 20,
        ),

        actions: <Widget>[
          CancelButton(),
          FlatButton(
            child: Text("priority_score".tr),
            onPressed: () => null,
          ),
          dynamicValues.userCanReserveBook(context)
              ? FlatButton(
            child: Text("reserve_book".tr),
            onPressed: () => null,
          )
              : Container()
        ],
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
      textDirection: ShamLocalizations.of(context).getDirection(),
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
                  child: RatingBar(
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
            onPressed: () => Navigator.pop(context, comment),
          )
        ],
      ),
    );
  }
}


