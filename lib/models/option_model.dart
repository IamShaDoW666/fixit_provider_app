import 'variant_model.dart';

class Option {
  int? id;
  String? name;
  int? multi;
  String? type;
  int? typeInt;
  int? unitPrice;
  int? area;
  bool? customizable;
  List<Variant>? variants;

  Option(
      {this.id,
      this.name,
      this.multi,
      this.type,
      this.typeInt,
      this.unitPrice,
      this.area,
      this.customizable,
      this.variants});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
        id: json['id'],
        name: json['name'],
        multi: json['multi'],
        type: json['type'],
        typeInt: json['type_int'],
        unitPrice: json['unit_price'],
        area: json['area'],
        customizable: json['customizable'],
        variants: json['variants'] != null
            ? (json['variants'] as List)
                .map((i) => Variant.fromJson(i))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['multi'] = this.multi;
    data['type'] = this.type;
    data['type_int'] = this.typeInt;
    data['unit_price'] = this.unitPrice;
    data['area'] = this.area;
    data['customizable'] = this.customizable;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
