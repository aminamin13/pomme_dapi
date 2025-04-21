import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomme_dapi/features/personalization/models/address_model.dart';
import 'package:pomme_dapi/features/shop/models/cart_item_model.dart';
import 'package:pomme_dapi/utils/constants/enums.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.docId = "",
    this.userId = "",
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = "Cash on Delivery",
    this.deliveryDate,
    this.shippingAddress,
    this.billingAddress,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate =>
      AppHelperFunctions.getFormattedDate(orderDate);

  String get formattedDelvierydate =>
      deliveryDate != null
          ? AppHelperFunctions.getFormattedDate(deliveryDate!)
          : '';

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? "Delivered"
          : status == OrderStatus.shipped
          ? "shippment on the way"
          : "Proccessing";

  static OrderModel empty() => OrderModel(
    id: "",
    status: OrderStatus.pending,
    items: [],
    totalAmount: 0,
    shippingCost: 0,
    taxCost: 0,
    orderDate: DateTime.now(),
  );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "status": status.toString(),
      "totalAmount": totalAmount,
      "shippingCost": shippingCost,
      "taxCost": taxCost,
      "orderDate": orderDate,
      "paymentMethod": paymentMethod,
      "shippingAddress": shippingAddress?.toJson(),
      "billingAddress": billingAddress?.toJson(),
      "deliveryDate": deliveryDate,
      "billingAddressSameAsShipping": billingAddressSameAsShipping,
      "items": items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      docId: snapshot.id,
      id: data.containsKey("id") ? data["id"] as String : "",
      userId: data.containsKey("userId") ? data["userId"] as String : "",
      status:
          data.containsKey("status")
              ? OrderStatus.values
                  .where((e) => e.toString() == data["status"])
                  .first
              : OrderStatus.pending,
      totalAmount:
          data.containsKey("totalAmount") ? data["totalAmount"] as double : 0.0,
      shippingCost:
          data.containsKey("shippingCost")
              ? (data["shippingCost"] as num).toDouble()
              : 0.0,
      taxCost:
          data.containsKey("taxCost")
              ? (data["taxCost"] as num).toDouble()
              : 0.0,
      orderDate:
          data.containsKey('orderDate')
              ? (data['orderDate'] as Timestamp).toDate()
              : DateTime.now(),
      paymentMethod:
          data.containsKey("paymentMethod")
              ? data["paymentMethod"] as String
              : '',
      billingAddressSameAsShipping:
          data.containsKey("billingAddressSameAsShipping")
              ? data["billingAddressSameAsShipping"] as bool
              : true,
      billingAddress:
          data.containsKey("billingAddress")
              ? AddressModel.fromMap(
                data["billingAddress"] as Map<String, dynamic>,
              )
              : AddressModel.empty(),
      shippingAddress:
          data.containsKey("shippingAddress")
              ? AddressModel.fromMap(
                data["shippingAddress"] as Map<String, dynamic>,
              )
              : AddressModel.empty(),
      deliveryDate:
          data.containsKey("deliveryDate") && data["deliveryDate"] != null
              ? (data["deliveryDate"] as Timestamp).toDate()
              : null,
      items:
          data.containsKey("items")
              ? (data["items"] as List)
                  .map(
                    (item) =>
                        CartItemModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList()
              : [],
    );
  }
}
