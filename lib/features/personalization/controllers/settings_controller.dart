import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pomme_dapi/data/repositories/settings/settings_repo.dart';
import 'package:pomme_dapi/features/personalization/models/settings_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;
  var isNotificationOn = true.obs;
  final localStorage = GetStorage();

  final settingsRepo = Get.put(SettingsRepository());

  @override
  void onInit() {
    fetchSettingDetails();
    loadNotificationSetting();

    super.onInit();
  }

  Future<SettingsModel> fetchSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingsRepo.getSettings();
      this.settings.value = settings;
      loading.value = false;
      return settings;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return SettingsModel();
    }
  }

  // Load saved notification setting
  Future<void> loadNotificationSetting() async {
    localStorage.read('notifications_enabled');
    isNotificationOn.value = localStorage.read('notifications_enabled') ?? true;
  }

  // Update and save notification setting
  Future<void> updateNotificationSetting(bool value) async {
    await localStorage.write('notifications_enabled', value);
    isNotificationOn.value = value;
  }
}
