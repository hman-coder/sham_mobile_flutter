import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/main_controller.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/models/offer.dart';
import 'package:sham_mobile/repositories/offers_repository.dart';

class OffersController extends ShamController {
  var _offers = <Offer>[].obs;

  List<Offer> get offers => _offers.toList();

  final OffersRepository _repo = OffersRepository();

  final RefreshController refreshController = RefreshController();

  @override
  void onReady() {
    loadMoreOffers();
    super.onReady();
  }

  void loadMoreOffers() async  {
    await Future.delayed(2.3.seconds);
    _offers.addAll(_repo.fetchOffers());

    refreshController.loadComplete();
  }

  void refreshOffers() async{
    await Future.delayed(1.seconds);
    _offers.clear();
    _offers.addAll(_repo.fetchOffers());

    refreshController.refreshCompleted();
  }

  void onOfferPressed(Offer offer) async {
    if(offer.destinationId < 0)
      Get.find<MainController>().switchToPageName(offer.destination);

    else
      print('else');
  }
}