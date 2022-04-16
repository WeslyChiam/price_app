class ProductModel {
  String? pid;
  String? name;
  int? price;
  String? company;
  String? category;
  String? material;
  String? writer;
  String? date;

  ProductModel(
      {this.pid,
      this.name,
      this.price,
      this.category,
      this.material,
      this.company,
      this.writer,
      this.date});

  factory ProductModel.fromMap(map) {
    return ProductModel(
      pid: map['pid'],
      name: map['productName'],
      price: map['price'],
      category: map['category'],
      material: map['material'],
      company: map['company'],
      writer: map['writer'],
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
      'writtenBy': writer,
      'date': date,
    };
  }
}

class ProductModelWthOtherField {
  String? pid;
  String? name;
  int? price;
  String? company;
  String? category;
  String? material;
  String? otherField;
  String? otherFieldDetail;
  String? writer;
  String? date;

  ProductModelWthOtherField(
      {this.pid,
      this.name,
      this.price,
      this.category,
      this.material,
      this.company,
      this.otherField,
      this.otherFieldDetail,
      this.writer,
      this.date});

  factory ProductModelWthOtherField.fromMap(map) {
    return ProductModelWthOtherField(
      pid: map['pid'],
      name: map['name'],
      price: map['price'],
      category: map['category'],
      material: map['material'],
      company: map['company'],
      otherField: map['otherField'],
      otherFieldDetail: map['otherFieldDetail'],
      writer: map['writer'],
      date: map['date'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'pid': pid,
      'productName': name,
      'price': price,
      'category': category,
      'material': material,
      'company': company,
      otherField: otherFieldDetail,
      'writtenBy': writer,
      'date': date,
    };
  }
}
