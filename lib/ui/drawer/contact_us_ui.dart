import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/ui/widgets/activatable_widget.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/ui/widgets/buttons/sham_screen_width_button.dart';
import 'package:sham_mobile/controllers/contact_us_controller.dart';

class ContactUsUI extends GetView<ContactUsController> {
  get subjects => controller.subjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('contact_us'.tr),
        ),
        body: Stack(
          children: [
            Obx(
              () => ActivatableWidget(
                isActive: ! controller.isSendingMessage,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildToLabel(context),
                        ),
                        _buildToCheckBoxes(),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildSubjectDropdownButton(context),
                        ),
                        _buildOtherSubjectField(),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: _buildContentField(),
                        ),
                        ShamScreenWidthButton(
                          color: kcMaroon,
                          onPressed: controller.sendMessage,
                          text: 'send'.tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Obx(() => controller.isSendingMessage
                ? Center(child: CircularProgressIndicator())
                : Container())
          ],
        ));
  }

  Widget _buildToLabel(BuildContext context) {
    return Text('send_to'.tr, style: Theme.of(context).textTheme.headline6);
  }

  Widget _buildToCheckBoxes() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Obx(
            () => Checkbox(
                value: controller.toLibrary,
                onChanged: (value) => controller.toLibrary = value),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text('library_management'.tr),
        ),
        Expanded(child: Container()),
        Expanded(
          flex: 5,
          child: Obx(
            () => Checkbox(
                value: controller.toApp,
                onChanged: (value) => controller.toApp = value),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text('app_management'.tr),
        ),
      ],
    );
  }

  Widget _buildSubjectDropdownButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'message_subject'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
          Obx(
            () => DropdownButton<String>(
              value: controller.subject,
              items: subjects
                  .map<DropdownMenuItem<String>>(
                      (item) => DropdownMenuItem<String>(
                            child: Text(item),
                            value: item,
                          ))
                  .toList(),
              onChanged: (value) => controller.subject = value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSubjectField() {
    return Obx(
      () => controller.subject != subjects[4]
          ? Container()
          : ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'enter_message_subject'.tr + '...'),
              ),
            ),
    );
  }

  Widget _buildContentField() {
    return TextField(
      maxLines: 10,
      onChanged: (text) => controller.content = text,
      decoration: InputDecoration(
        hintText: 'enter_message_content'.tr + '...',
        border: OutlineInputBorder(),
      ),
    );
  }
}
