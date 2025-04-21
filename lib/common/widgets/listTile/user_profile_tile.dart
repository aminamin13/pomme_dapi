import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pomme_dapi/common/widgets/images/app_circular_image.dart';
import 'package:pomme_dapi/common/widgets/shimmer/shimmer_effect.dart';
import 'package:pomme_dapi/features/personalization/controllers/user_controller.dart';
import 'package:pomme_dapi/features/personalization/screens/profile/profile_screen.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';

class AppUserProfile extends StatelessWidget {
  const AppUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : AppImages.user;
        return controller.imageUploading.value == true
            ? const AppShimmerEffect(width: 80, height: 80, radius: 80)
            : AppCircularImage(
              image: image,
              isNetworkImage: networkImage.isNotEmpty,
              height: 80,
              width: 80,
              padding: 0,
            );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.apply(color: AppColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: AppColors.white),
      ),
      trailing: IconButton(
        onPressed: () {
          Get.to(const ProfileScreen());
        },
        icon: const Icon(Iconsax.edit, color: AppColors.white),
      ),
    );
  }
}
