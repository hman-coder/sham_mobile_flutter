import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/blind_dates_controller.dart';
import 'package:sham_mobile/models/blind_date.dart';
import 'package:sham_mobile/widgets_ui/loading_footer.dart';
import 'package:get/get.dart';

/// There is a small bug in using getx with pull_to_refresh
/// If you want to use a ListView in wrapped in an Obx widget
/// as a child of SmartRefresher, loading and pull-to-refresh
/// functions will not work.
/// This is because pull_to_refresh treats Widgets differently than
/// Slivers (or SliverLists), and Obx is a widget.
///
/// To avoid the issue, a StatefulWidget has been used instead
/// of a GetView<BooksController>
class BlindDatesUI extends GetView<BlindDatesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('blind_dates'.tr)),
      body: Obx(() => controller.blindDates.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SmartRefresher(
              controller: controller.refreshController,
              onLoading: controller.loadMoreBlindDates,
              onRefresh: controller.refreshBlindDates,
              enablePullUp: true,
              footer: LoadingFooter(),
              child: ListView.builder(
                itemCount: controller.blindDates.length,
                itemBuilder: (context, index) => _BlindDateItem(blindDate: controller.blindDates[index],)
              )
            ),
      ),
    );
  }
}

class _BlindDateItem extends StatefulWidget {
  final BlindDate blindDate;

  const _BlindDateItem({Key key, this.blindDate}) : super(key: key);

  @override
  _BlindDateItemState createState() => _BlindDateItemState();
}

class _BlindDateItemState extends State<_BlindDateItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<BlindDatesController>().requestBlindDate(widget.blindDate),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 75),
        child: Card(
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 5.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 40,
                  child: SizedBox(
                    height: 200,
                    child: Container(
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),),
                          image: DecorationImage(
                              image: AssetImage(widget.blindDate.image),
                              fit: BoxFit.fill
                          ),
                        )
                    ),),
                ),

                Expanded(
                  flex: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text(widget.blindDate.description)),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}