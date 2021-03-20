import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/family.dart';
import 'package:sham_mobile/models/family_member.dart';

class FamilyInfoController extends GetxController {
  var _mockFamily = Family.mock.obs;

  List<FamilyMember> get parents => _mockFamily.value.parents;

  List<FamilyMember> get children => _mockFamily.value.children;

  String get familyName => _mockFamily.value.familyName;

  String get code => _mockFamily.value.code;

  set familyName(String newFamilyName) {
    if (newFamilyName.isNotEmpty)
      _mockFamily.value = _mockFamily.value.copyWith(
        familyName: newFamilyName,
      );
    else {
      Get.find<ShamMessageController>().showMessage(ShamMessage(
        severity: MessageSeverity.mild,
        displayType: MessageDisplayType.snackbar,
        message: 'text_is_empty'.tr,
      ));
    }
  }

  /// Returns [true] if child is successfully added
  /// [false] otherwise
  Future<bool> addChild(Child child) async {
    ShamMessageController smc = Get.find<ShamMessageController>();
    if (child.name.isEmpty) {
      smc.showMessage(
        ShamMessage(
          severity: MessageSeverity.mild,
          displayType: MessageDisplayType.snackbar,
          message: 'must_provide_child_name'.tr + '.',
        ),
      );
      return false;
    } else if (child.birthday == null) {
      smc.showMessage(
        ShamMessage(
          severity: MessageSeverity.mild,
          displayType: MessageDisplayType.snackbar,
          message: 'must_provide_child_birthday'.tr + '.',
        ),
      );
      return false;
    } else {
      _mockFamily.update((value) => value.children.add(child));
      return true;
    }
  }

  void deleteFamily() async {
    bool confirmation =
        await Get.find<ShamMessageController>().showConfirmation(
      title: 'confirm_family_removal_header'.tr,
      message: 'confirm_family_removal_message'.tr +
          '\n\n' +
          'confirm_continue'.tr +
          'question_mark'.tr,
    );
  }
}
