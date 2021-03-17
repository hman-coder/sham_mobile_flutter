import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/offers_controller.dart';
import 'package:sham_mobile/models/offer.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/loading_footer.dart';
import 'package:sham_mobile/ui/drawer_ui.dart';

class OffersUI extends GetView<OffersController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUI(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('offers'.tr),
      ),
      body: Obx(() => controller.offers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
            controller: controller.refreshController,
            footer: LoadingFooter(),
            enablePullUp: true,
            onLoading: controller.loadMoreOffers,
            onRefresh: controller.refreshOffers,
            child: ListView.builder(
              itemBuilder: (_, index) => OfferWidget(controller.offers[index]),
              itemCount: controller.offers.length,
            )
          ),
      ),
    );
  }
}

class OfferWidget extends GetView<OffersController> {
  final Offer offer;

  const OfferWidget(this.offer, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(12),),
      ),
      margin: EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        onTap: () => controller.onOfferPressed(offer),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, offset: Offset(0, 1.5),),
                  BoxShadow(color: Colors.black54, offset: Offset(0, 2),),
                  BoxShadow(color: Colors.black26, offset: Offset(0, 2.5),),
                  BoxShadow(color: Colors.black26, offset: Offset(0, 3),),
                ],
                color: DefaultValues.kcMaroon,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Center(
                child: Text(offer.title,
                  style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 48),
              child: Row(
                children: [
                  Flexible(
                    flex: 70,
                    child: Center(
                      child: Padding(padding: EdgeInsets.all(12),child: Text(offer.description)),
                    ),
                  ),

                  Expanded(
                    flex: 30,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.asset(offer.image, fit: BoxFit.fill,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}