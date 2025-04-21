import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/appbar/app_bar.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/features/personalization/controllers/upload_data_controller.dart';
import 'package:pomme_dapi/features/personalization/screens/loadData/widgets/load_data_tile.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          "Load Data",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            const AppSectionHeading(title: "Main Records"),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Categories",
              icon: Iconsax.category,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyCategories();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Brands",
              icon: Iconsax.image,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyBrands();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Products",
              icon: Iconsax.forward_item,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyProducts();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Banners",
              icon: Iconsax.picture_frame,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyBanners();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const AppSectionHeading(title: "Relationships"),
            Text(
              "Make sure you have already uploaded all the content above",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Brands & Categories Relation Data",
              icon: Iconsax.image,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyBrandsCategory();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            AppLoadDataTile(
              title: "Upload Products",
              icon: Iconsax.forward_item,
              trailing: IconButton(
                onPressed: () {
                  controller.upLoadDummyProductsCategory();
                },
                icon: const Icon(Icons.upload, color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
