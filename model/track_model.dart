class TrackModel {
  String? id;
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? category;
  String? wroteBy;
  String? action;
  String? date;
  bool? approve;

  TrackModel(
      {this.id,
      this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.category,
      this.wroteBy,
      this.date,
      this.action,
      this.approve});

  factory TrackModel.fromMap(map) {
    return TrackModel(
      id: map['id'],
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      category: map['category'],
      wroteBy: map['wroteBy'],
      action: map['action'],
      date: map['date'],
      approve: map['approve'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pid': pid,
      'productName': productName,
      'price': price,
      'distributor': distributor,
      'material': material,
      'category': category,
      'action': action,
      'wroteBy': wroteBy,
      'writtenDate': date,
      'approve': approve,
    };
  }
}

class TrackModelWthOther {
  String? atrName;
  String? atrDetail;

  TrackModelWthOther({
    this.atrName,
    this.atrDetail,
  });

  factory TrackModelWthOther.fromMap(map) {
    return TrackModelWthOther(
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
