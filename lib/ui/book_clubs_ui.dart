import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/book_clubs_controller.dart';
import 'package:sham_mobile/helpers/string_helper.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/ui/drawer_ui.dart';
import 'package:sham_mobile/widgets_ui/linear_gradient_background.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets_ui/loading_footer.dart';

class BookClubsUI extends GetView<BookClubsController> {
  BookClubsUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        drawer: DrawerUI(),
        body: Obx(() => SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onLoading: controller.loadMoreClubs,
              onRefresh: controller.refreshClubs,
              footer: LoadingFooter(),
              child: CustomScrollView(slivers: _buildBookClubs(controller.bookClubs).toList())
          ),
        ),
      );
  }

  Widget _buildAppBar() {
    return AppBar(
        centerTitle: true,
        title: Text('book_clubs'.tr));
  }

  Iterable<Widget> _buildBookClubs(List<Activity> bookClubs) sync* {
    for (Activity club in bookClubs) {
      yield* _buildBookClubItem(club);
    }
  }

  Iterable<Widget> _buildBookClubItem(Activity bookClub) sync*{
    yield SliverPadding(
      padding: EdgeInsets.all(0.0),
      sliver: SliverAppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        primary: false,
        expandedHeight: 150.0,
        stretch: true,
        flexibleSpace: GestureDetector(
          onTap: () => print("Pressed ${bookClub.title}"),
          child: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                right: 10,
                left: 10),
            title: Text(bookClub.title,
                  style: DefaultValues.sliverAppBarTextStyleWithShadow
              ),
            background: LinearGradientBackground(
                color: Colors.black54,
                child: Image.asset(bookClub.image, fit: BoxFit.cover,)),
          ),
        ),
      ),
    );

    yield SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(height: 10,),
            _buildLabelValuePair('age_group'.tr, bookClub.ageGroup.toString()),
            _buildLabelValuePair('frequency'.tr, bookClub.frequency),
            _buildLabelValuePair('next_session'.tr, StringHelper.dateToString(bookClub.nextSession)),
            _buildLabelValuePair('participants'.tr, '${bookClub.participants} \\ ${bookClub.slots}'),
            _buildMoreInfoButton(bookClub),
            Container(height: 15.0),
            Divider(
              color: Colors.black,
              height: 3.0,
              thickness: 3,)
          ],
        )
    );
  }

  Widget _buildLabelValuePair(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 15.0, left: 15.0, top:5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: Get.direction,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Text(label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
          ),

          Expanded(
            flex: 5,
            child: Text(value,
              style: TextStyle(
                  fontSize: 16,
                  color: DefaultValues.maroon
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreInfoButton(Activity bookClub) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Text('more_info'.tr,
                  style: TextStyle(
                      color: Colors.blue
                  )
              ),

              onTap: () => print("Go to book club ${bookClub.title}"),
            )
          ]
      ),
    );
  }
}