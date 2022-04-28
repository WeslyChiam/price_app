class ProductModel {
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? category;
  String? wroteBy;
  String? date;

  ProductModel(
      {this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.category,
      this.wroteBy,
      this.date});

  factory ProductModel.fromMap(map) {
    return ProductModel(
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      category: map['category'],
      wroteBy: map['wroteBy'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'productName': productName,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'wroteBy': wroteBy,
      'writtenDate': date,
    };
  }
}

class ProductModelWthOther {
  String? atrName;
  String? atrDetail;

  ProductModelWthOther({
    this.atrName,
    this.atrDetail,
  });

  factory ProductModelWthOther.fromMap(map) {
    return ProductModelWthOther(
      atrName: map['atrName'],
      atrDetail: map['atrDetail'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'atrName': atrName,
      'atrDetail': atrDetail,
    };
  }
}
