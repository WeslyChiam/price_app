class TrackModel {
  String? id;
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? type;
  String? category;
  String? wroteBy;
  String? action;
  List? list;
  String? date;
  bool? approve;

  TrackModel(
      {this.id,
      this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.type,
      this.category,
      this.wroteBy,
      this.date,
      this.action,
      this.list,
      this.approve});

  factory TrackModel.fromMap(map) {
    return TrackModel(
      id: map['id'],
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      type: map['type'],
      category: map['category'],
      wroteBy: map['wroteBy'],
      action: map['action'],
      list: map['list'],
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
      'type': type,
      'category': category,
      'action': action,
      'list': list,
      'wroteBy': wroteBy,
      'writtenDate': date,
      'approve': approve,
    };
  }
}

class TrackModelWthOther {
  String? id;
  String? pid;
  String? productName;
  String? price;
  String? distributor;
  String? material;
  String? category;
  String? atrName;
  String? atrDetail;
  String? wroteBy;
  String? action;
  String? date;
  bool? approve;

  TrackModelWthOther(
      {this.id,
      this.pid,
      this.productName,
      this.price,
      this.distributor,
      this.material,
      this.category,
      this.atrName,
      this.atrDetail,
      this.wroteBy,
      this.date,
      this.action,
      this.approve});

  factory TrackModelWthOther.fromMap(map) {
    return TrackModelWthOther(
      id: map['id'],
      pid: map['pid'],
      productName: map['productName'],
      price: map['price'],
      distributor: map['distributor'],
      material: map['material'],
      category: map['category'],
      atrName: map['atrName'],
      atrDetail: map['atrDetail'],
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
      'otherAtr': {
        '0': {
          'atrName': atrName,
          'atrDetail': atrDetail,
        },
      },
      'action': action,
      'wroteBy': wroteBy,
      'writtenDate': date,
      'approve': approve,
    };
  }
}
