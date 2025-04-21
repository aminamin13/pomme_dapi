import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;

  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
  });
  Map<String, dynamic> toJson() {
    return {
      "taxRate": taxRate,
      "shippingCost": shippingCost,
      "freeShippingThreshold": freeShippingThreshold,
    };
  }

  factory SettingsModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return SettingsModel(
        id: document.id,
        taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.0,
        shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
        freeShippingThreshold:
            (data['freeShippingThreshold'] as num?)?.toDouble(),
      );
    } else {
      return SettingsModel();
    }
  }
}
