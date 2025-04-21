import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AutheticationRepository.instance.authUser!.uid;

      if (userId.isEmpty) {
        throw "Unable tp Find User Information, Try Again Later";
      }

      final result =
          await _db
              .collection("Users")
              .doc(userId)
              .collection("Addresses")
              .get();
      return result.docs
          .map(
            (documentSnapshot) =>
                AddressModel.fromDcumentSnapshot(documentSnapshot),
          )
          .toList();
    } catch (e) {
      throw "Something Went Wrong while Fetching Address Information";
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AutheticationRepository.instance.authUser!.uid;
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw "Something Went Wrong while Fetching Address Information";
    }
  }

  // Store new user order
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AutheticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again later';
    }
  }
}
