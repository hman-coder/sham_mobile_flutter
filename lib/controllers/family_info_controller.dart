import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/family.dart';
import 'package:sham_mobile/models/family_member.dart';

class FamilyInfoController extends GetxController {
  List<FamilyMember> get parents => _mockFamily.parents;

  List<FamilyMember> get children => _mockFamily.children;

  String get familyName => _mockFamily.familyName;

  String get code => _mockFamily.code;

  Family _mockFamily = Family.mock;

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
      this.children.add(child);
    }
  }
}
