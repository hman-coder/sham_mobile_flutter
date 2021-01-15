import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sham_mobile/filter/filter_controller.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/models/summerizable.dart';

class FiltersUI extends GetView<FilterController> {
  final int kNumberOfFilters = 5;

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
              ListView.separated(
                itemCount: kNumberOfFilters,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Obx(() =>
                          _buildFilterTile(
                            filterIsApplied: controller.categories.isNotEmpty,
                            title: 'categories'.tr,
                            subtitle: controller.categories.isNotEmpty
                                ? controller.categories.summarize(
                                separator: 'comma'.tr)
                                : 'no_items_added'.tr,
                            onTap: controller.showCategoriesDialog,),
                      );

                    case 1:
                      return Obx(() =>
                          _buildFilterTile(
                              filterIsApplied: controller.ageGroups.isNotEmpty,
                              title: 'age_groups'.tr,
                              subtitle: controller.ageGroups.isNotEmpty
                                  ? controller.ageGroups.summarize(
                                  separator: 'comma'.tr)
                                  : 'no_items_added'.tr,
                              onTap: controller.showAgeGroupsDialog),
                      );

                    case 2:
                      return Obx(() =>
                          _buildFilterTile(
                              filterIsApplied: controller.authors.isNotEmpty,
                              title: 'authors'.tr,
                              subtitle: controller.authors.isNotEmpty
                                  ? controller.authors.summarize(
                                  separator: 'comma'.tr)
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
                                  ? controller.specialCategories.summarize(
                                  separator: 'comma'.tr)
                                  : 'no_items_added'.tr,
                              onTap: controller.showSpecialCategoriesDialog
                          ),
                      );

                    case 4:
                      return Obx(() =>
                          _buildFilterTile(
                              filterIsApplied: controller.ratingRange[0] > 0,
                              subtitle: controller.ratingRange[0] > 0
                                  ? '${controller.ratingRange[0]} - ${controller
                                  .ratingRange[1]}'
                                  : 'no_items_added'.tr,
                              title: 'rating'.tr,
                              onTap: controller.showRatingDialog
                          ),
                      );

                    default:
                      return Container();
                  }
                },
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

  Widget _buildFilterTile({String title, String subtitle, Function() onTap, bool filterIsApplied}) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(fontSize: DefaultValues.largeTextSize)),
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