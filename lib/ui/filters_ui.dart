import 'package:flutter/material.dart';
import 'package:sham_mobile/controllers/filter_controller.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/models/summerizable.dart';
import 'package:sham_mobile/widgets_ui/sham_screen_width_button.dart';

class FiltersUI extends GetView<FilterController> {
  final int kNumberOfItems = 6;

  final double kBottomButtonsHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: Scaffold(
          appBar: AppBar(
            title: Text('advanced_search'.tr),
            actions: <Widget>[
              IconButton(
                onPressed: Get.back,
                icon: Icon(Icons.search),
              )
            ],
          ),

          body: Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                // width: MediaQuery.of(context).size.width,
                top: 0,
                bottom: kBottomButtonsHeight,
                child: _buildAllFilterTiles(),
              ),

              Positioned(
                height: kBottomButtonsHeight,
                right: 0,
                left: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShamScreenWidthButton(
                      text: 'apply'.tr,
                      onPressed: controller.returnResult,
                    ),

                    SizedBox(height: 10),

                    ShamScreenWidthButton(
                      height: 40,
                      text: 'remove_all'.tr,
                      color: Colors.transparent,
                      textColor: Colors.black,
                      splashColor: Colors.white,
                      onPressed: controller.clearAll,
                    ),
                  ],
                )
              ),

              Obx(() => ! controller.isLoading ? Container()
                  : SizedBox.expand(child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35, maxWidth: 35),
                    child: CircularProgressIndicator(),
                  ))),
            ]
          )
      ),
    );
  }

  Widget _buildAllFilterTiles() {
    return ListView.separated(
      itemCount: kNumberOfItems,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Obx(() =>
                _buildFilterTile(
                  filterIsApplied: controller.categories.isNotEmpty,
                  title: 'categories'.tr,
                  subtitle: controller.categories.isNotEmpty
                      ? controller.categories.summarize(separator: 'comma'.tr)
                      : 'no_items_added'.tr,
                  onTap: controller.showCategoriesDialog,),
            );

          case 1:
            return Obx(() =>
                _buildFilterTile(
                    filterIsApplied: controller.ageGroups.isNotEmpty,
                    title: 'age_groups'.tr,
                    subtitle: controller.ageGroups.isNotEmpty
                        ? controller.ageGroups.summarize(separator: 'comma'.tr)
                        : 'no_items_added'.tr,
                    onTap: controller.showAgeGroupsDialog),
            );

          case 2:
            return Obx(() =>
                _buildFilterTile(
                    filterIsApplied: controller.authors.isNotEmpty,
                    title: 'authors'.tr,
                    subtitle: controller.authors.isNotEmpty
                        ? controller.authors.summarize(separator: 'comma'.tr)
                        : 'no_items_added'.tr,
                    onTap: controller.showAuthorsDialog),
            );

          case 3:
            return Obx(() =>
                _buildFilterTile(
                    filterIsApplied: controller.specialCategories
                        .isNotEmpty,
                    title: 'special_categories'.tr,
                    subtitle: controller.specialCategories.isNotEmpty
                        ? controller.specialCategories.summarize(separator: 'comma'.tr)
                        : 'no_items_added'.tr,
                    onTap: controller.showSpecialCategoriesDialog
                ),
            );

          case 4:
            return Obx(() =>
                _buildFilterTile(
                    filterIsApplied: controller.hasRating,
                    subtitle: controller.hasRating
                        ? '${controller.ratingRange[0]} - ${controller.ratingRange[1]}'
                        : 'no_items_added'.tr,
                    title: 'rating'.tr,
                    onTap: controller.showRatingDialog
                ),
            );

          case 5:
            return Obx(() =>
                _buildFilterTile(
                    filterIsApplied: controller.hasPages,
                    subtitle: controller.hasPages
                        ? '${controller.pagesRange[0]} - ${controller.pagesRange[1]}'
                        : 'no_items_added'.tr,
                    title: 'page_count'.tr,
                    onTap: controller.showPagesDialog
                ),
            );

          case 6:
            return ShamScreenWidthButton(
              text: 'confirm'.tr,
              onPressed: controller.returnResult,
            );

          default:
            return Container();
        }
      },
    );
  }

  Widget _buildFilterTile({String title, String subtitle, Function() onTap, bool filterIsApplied}) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(fontSize: ktsLargeTextSize)),
      subtitle: Text(subtitle ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,),
      trailing: Icon(
          filterIsApplied
          ? Icons.playlist_add_check
          : Icons.list,

          color:
          filterIsApplied
              ? Colors.blue
              : Colors.grey
      ),
    );
  }
}