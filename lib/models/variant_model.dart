class Variant {
  int? id;
  String? name;
  int? price;
  int? packageArea;
  String? priceFormat;
  bool? showDescription;
  String? description;

  Variant(
      {this.id,
      this.name,
      this.price,
      this.packageArea,
      this.priceFormat,
      this.description,
      this.showDescription});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        priceFormat: json['price_format'],
        packageArea: json['package_area'],
        description: json['description'],
        showDescription: json['show_description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_format'] = this.priceFormat;
    data['package_area'] = this.packageArea;
    data['description'] = this.description;
    data['show_description'] = this.showDescription;
    return data;
  }
}
