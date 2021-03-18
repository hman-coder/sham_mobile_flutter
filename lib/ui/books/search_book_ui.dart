import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/search_book_controller.dart';
import 'package:sham_mobile/ui/widgets/tiles/book_tile.dart';

class SearchBookUI extends GetView<SearchBookController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (string) => controller.search(),
          controller: controller.textFieldController,
          onChanged: controller.setSearchText,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'search'.tr,
            border: UnderlineInputBorder(borderSide: BorderSide.none)
          ),
        ),
        leading: BackButton(onPressed: Get.back, color: Colors.grey),
        backgroundColor: Colors.white,
        actions:  _buildActions()
      ),

      body: Obx(() {
        if(controller.showResults && controller.results.isEmpty)
          return Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: controller.showResults
              ? controller.results.length
              : controller.suggestions.length,
          itemBuilder: (BuildContext context, int index) =>
            controller.showResults
                ? BookTile(book: controller.results[index], )
                : ListTile(
                  title: Text(controller.suggestions[index]),
                  onTap: () => controller.selectSuggestionAtIndex(index)
            ),
      );}
      )
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.grey),
        onPressed: controller.clearSearch,
      ),

      IconButton(
          icon: Icon(Icons.search, color: Colors.grey),
          onPressed: controller.search
      )
    ];
  }
}
