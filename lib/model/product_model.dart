class ProductModel {
  String? pid;
  String? name;
  int? price;
  String? company;
  String? category;
  String? material;
  String? date;

  ProductModel(
      {this.pid,
      this.name,
      this.price,
      this.category,
      this.material,
      this.company,
      this.date});

  factory ProductModel.fromMap(map) {
    return ProductModel(
      pid: map['pid'],
      name: map['productName'],
      price: map['price'],
      category: map['category'],
      material: map['material'],
      company: map['company'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'productName': name,
      'price': price,
      'category': category,
      'material': material,
      'company': company,
      'date': date,
    };
  }
}
