import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/common/widgets/texts/section_heading.dart';
import 'package:pomme_dapi/data/repositories/address/address_repository.dart';
import 'package:pomme_dapi/features/personalization/models/address_model.dart';
import 'package:pomme_dapi/features/personalization/screens/address/add_new_address.dart';
import 'package:pomme_dapi/features/personalization/screens/address/widgets/single_address.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/helpers/cloud_helper_functions.dart';
import 'package:pomme_dapi/utils/helpers/network_manager.dart';
import 'package:pomme_dapi/utils/loaders/snackbar.dart';
import 'package:pomme_dapi/utils/popups/full_screen_loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  RxBool refreshData = true.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<List<AddressModel>> getAllUsersAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
      return [];
    }
  }

  Future selecteAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: Container(
          height: 200,
          width: 200,
          color: Colors.transparent,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );

      // clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      // set the slected field to true for the new selected address
      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );
      Get.back();
    } catch (e) {
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "Adding Address...",
        AppImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: "",
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selecteAddress(address);

      AppFullScreenLoader.stopLoading();

      AppLoaders.successSnackBar(
        title: "Success",
        message: "Address Added Successfully",
      );

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSectionHeading(title: "Select Address"),
                    FutureBuilder(
                      future: getAllUsersAddresses(),
                      builder: (_, snapshot) {
                        final response =
                            AppCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                            );
                        if (response != null) return response;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder:
                              (_, index) => SingleAddress(
                                address: snapshot.data![index],
                                onTap: () async {
                                  await selecteAddress(snapshot.data![index]);
                                  Get.back();
                                },
                              ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSizes.defaultSpace * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Get.to(() => const AddNewAddressScreen());
                          // Refresh state after adding new address
                          setState(() {});
                        },
                        child: const Text("Add New Address"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
