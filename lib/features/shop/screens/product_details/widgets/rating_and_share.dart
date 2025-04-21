import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pomme_dapi/features/shop/controllers/product/product_controller.dart';
import 'package:pomme_dapi/features/shop/models/product_model.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:share_plus/share_plus.dart';

class AppRatingandShare extends StatelessWidget {
  const AppRatingandShare({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Row(
        //   children: [
        //     const Icon(Iconsax.star5, color: Colors.amber, size: 25),
        //     const SizedBox(width: AppSizes.spaceBtwItems / 2),
        //     Text.rich(
        //       TextSpan(
        //         children: [
        //           TextSpan(
        //             text: "5.0",
        //             style: Theme.of(context).textTheme.bodyLarge,
        //           ),
        //           const TextSpan(text: "(999)"),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        IconButton(
          onPressed: () async {
            try {
              // Download image from URL
              final response = await http.get(Uri.parse(product.thumbnail));
              final bytes = response.bodyBytes;

              // Get local temporary directory
              final dir = await getTemporaryDirectory();
              final file = File('${dir.path}/shared_image.jpg');

              // Save the image file
              await file.writeAsBytes(bytes);

              // Share the downloaded file
              await Share.shareXFiles([XFile(file.path)], text: product.title);
            } catch (e) {
              print('Error sharing file: $e');
            }
          },
          icon: const Icon(Icons.share, size: AppSizes.iconMd),
        ),
      ],
    );
  }
}
