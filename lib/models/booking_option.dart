import 'package:handyman_provider_flutter/models/option_model.dart';
import 'package:handyman_provider_flutter/models/variant_model.dart';

class BookingOption {
  int? id;
  int? bookingId;
  int? optionId;
  int? variantId;
  Option? option;
  Variant? variant;
  int? quantity;

  BookingOption(
      {this.id,
      this.bookingId,
      this.optionId,
      this.variantId,
      this.option,
      this.variant,
      this.quantity});

  BookingOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    optionId = json['option_id'];
    variantId = json['variant_id'];
    variant =
        json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    option =
        json['option'] != null ? new Option.fromJson(json['option']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['option_id'] = this.optionId;
    data['variant_id'] = this.variantId;
    data['option'] = this.option;
    data['variant'] = this.variant;
    data['quantity'] = this.quantity;
    return data;
  }
}
