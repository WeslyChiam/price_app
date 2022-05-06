class ProductModel {
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? type;
  String? category;
  List? list;
  String? wroteBy;
  String? date;

  ProductModel(
      {this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.type,
      this.category,
      this.list,
      this.wroteBy,
      this.date});

  factory ProductModel.fromMap(map) {
    return ProductModel(
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      type: map['type'],
      category: map['category'],
      list: map['list'],
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
      'type': type,
      'category': category,
      'wroteBy': wroteBy,
      'writtenDate': date,
    };
  }
}

class ProductModelWthOther {
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? category;
  String? atrName;
  String? atrDetail;
  String? wroteBy;
  String? date;

  ProductModelWthOther(
      {this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.category,
      this.atrName,
      this.atrDetail,
      this.wroteBy,
      this.date});

  factory ProductModelWthOther.fromMap(map) {
    return ProductModelWthOther(
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      category: map['category'],
      atrName: map['atrName'],
      atrDetail: map['atrDetail'],
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
      'otherAtr': {
        '0': {
          'atrName': atrName,
          'atrDetail': atrDetail,
        },
      },
      'wroteBy': wroteBy,
      'writtenDate': date,
    };
  }
}
