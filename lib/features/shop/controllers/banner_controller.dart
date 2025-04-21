import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/banners/banners_repository.dart';
import 'package:pomme_dapi/features/shop/models/banners_model.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';

class BannerController extends GetxController {
  static BannerController instance = Get.find();

  final Rx<int> carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  RxList<BannersModel> banners = <BannersModel>[].obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // fetch banners
  Future<void> fetchBanners() async {
    try {
      // show loader while loading categories
      isLoading.value = true;

      // Fetech categories from data source
      final bannersRepository = Get.put(BannersRepository());

      final banners = await bannersRepository.getAllBanners();

      // update the categories list

      this.banners.assignAll(banners);
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
