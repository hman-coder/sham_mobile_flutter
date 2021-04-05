import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/family.dart';
import 'package:sham_mobile/models/family_member.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';

class FamilyInfoController extends ShamController {
  Rx<Family> _family;

  List<FamilyMember> get parents => _family?.value?.parents;

  List<FamilyMember> get children => _family?.value?.children;

  String get familyName => _family?.value?.familyName;

  String get code => _family?.value?.code;

  var _hasFamily = false.obs;

  bool get hasFamily => _hasFamily.value;

  set familyName(String newFamilyName) {
    if (newFamilyName.isNotEmpty)
      _family.value = _family.value.copyWith(
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

  @override
  void onInit() {
    _updateHasFamily();
    super.onInit();
  }

  void createFamilyFromName(String name) async {
    isLoading = true;

    // Web API call
    await Future.delayed(1.seconds);
    var newFamily = Family.mock.copyWith(familyName: name);

    // Create the new family object
    if(_family == null)
      _family = newFamily.obs;
    else
      _family.value = newFamily;

    // Update hasFamily property
    _updateHasFamily();

    isLoading = false;
  }

  /// Updates hasFamily property with correct value
  void _updateHasFamily() {
    _hasFamily.value = _family?.value != null;
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
      _family.update((value) => value.children.add(child));
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

    if (confirmation)
      this._family.value = null;

    _updateHasFamily();
  }

  Future<bool> joinFamilyWithCode(String code) async {
    isLoading = true;

    ShamMessageController messageCenter = Get.find<ShamMessageController>();
    // Verify code length
    if (code.length != 6) {
      messageCenter.showMessage(ShamMessage(
        severity: MessageSeverity.moderate,
        displayType: MessageDisplayType.snackbar,
        message: 'family_code_is_six_digits'.tr + '.',
      ));
      isLoading = false;

    // Verify code matches a family code
    } else if (code != this.code) {
      await Future.delayed(1.seconds);
      isLoading = false;
      messageCenter.showMessage(ShamMessage(
        severity: MessageSeverity.moderate,
        displayType: MessageDisplayType.snackbar,
        message: 'family_not_found'.tr + '.',
      ));
      return false;

    // Code is correct.
    } else {
      await Future.delayed(1.seconds);
      isLoading = false;
      // Hide dialog
      Get.back();

      // Show notification
      messageCenter.showMessage(ShamMessage(
        severity: MessageSeverity.mild,
        displayType: MessageDisplayType.snackbar,
        message: 'join_family_request_sent'.tr + '.',
      ));
      return true;
    }
  }
}
