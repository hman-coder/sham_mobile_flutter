import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/accounting_controller.dart';
import 'package:sham_mobile/models/purchase_record.dart';
import 'package:sham_mobile/constants/default_widgets.dart';
import 'package:sham_mobile/ui/no_items_to_show_ui.dart';
import 'package:sham_mobile/ui/widgets/loading_footer.dart';
import 'package:sham_mobile/helpers/string_helper.dart';
import 'package:sham_mobile/ui/widgets/on_click_tooltip.dart';

class AccountingUI extends GetView<AccountingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('account'.tr)),
      body: Obx(
        () {
          if (controller.purchaseRecords.isEmpty && controller.isLoading)
            return Center(child: CircularProgressIndicator());
          else if (controller.purchaseRecords.isEmpty && !controller.isLoading)
            return NoItemsToShowUI();
          else
            return SmartRefresher(
              onLoading: controller.loadMorePurchaseRecords,
              onRefresh: controller.refreshPurchaseRecords,
              footer: LoadingFooter(),
              enablePullUp: !controller.allItemsAreLoaded,
              controller: controller.refreshController,
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _TableHeaderDelegate(),
                    floating: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _PurchaseRecordWidget(
                          purchaseRecord: controller.purchaseRecords[index]),
                      childCount: controller.purchaseRecords.length,
                    ),
                  )
                ],
              ),
            );
        },
      ),
    );
  }
}

class _PurchaseRecordWidget extends StatelessWidget {
  final PurchaseRecord purchaseRecord;

  _PurchaseRecordWidget({Key key, @required this.purchaseRecord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: _PurchaseRecordRow(
        dividerColor: Colors.black,
        children: [
          OnClickTooltip(
            message: purchaseRecord.itemName,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  purchaseRecord.itemType.icon,
                ),
                verticalTinySpacer,
                Text(
                  purchaseRecord.itemType.translatedName,
                ),
              ],
            ),
          ),
          Text(purchaseRecord.purchaseMadeBy),
          Text(purchaseRecord.payment.toString()),
          Text(purchaseRecord.dateTime.toShamFormattedString()),
        ],
      ),
    );
  }
}

/// A row with default column widths used specifically for this view
class _PurchaseRecordRow extends StatelessWidget {
  final List<Widget> children;

  final Color dividerColor;

  const _PurchaseRecordRow(
      {Key key, this.dividerColor, @required this.children})
      : assert(children.length == 4,
            'Purchase Item row must have exactly 4 children'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 60,
            minWidth: 85,
          ),
          child: Center(child: children[0]),
        ),
        VerticalDivider(thickness: 1, color: dividerColor),
        Expanded(
          flex: 38,
          child: Center(
            child: children[1],
          ),
        ),
        VerticalDivider(thickness: 1, color: dividerColor),
        Expanded(
          flex: 38,
          child: Center(
            child: children[2],
          ),
        ),
        VerticalDivider(thickness: 1, color: dividerColor),
        Expanded(
          flex: 38,
          child: Center(
            child: children[3],
          ),
        ),
      ],
    );
  }
}

class _TableHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: _PurchaseRecordRow(
        dividerColor: Colors.white,
        children: [
          Center(
            child: Text('purchase_record_subject'.tr,
                style: TextStyle(color: Colors.white)),
          ),
          Text('purchase_record_made_by'.tr,
              style: TextStyle(color: Colors.white)),
          Text('purchase_record_payment'.tr,
              style: TextStyle(color: Colors.white)),
          Text('date'.tr, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant _TableHeaderDelegate oldDelegate) {
    return false;
  }
}
