import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/data/repositories/authentication_repository.dart';
import 'package:pomme_dapi/features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get All order related to current user

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AutheticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw " Unable to find user information, try again later";
      final result =
          await _db.collection("Users").doc(userId).collection("Orders").get();
      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw " Something went wrong, try again later";
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Orders")
          .add(order.toJson());
    } catch (e) {
      throw "Something went wrong, try again later";
    }
  }
}
