class GetMyProductsModel {
  bool? status;
  String? msg;
  List<Data>? data;

  GetMyProductsModel({this.status, this.msg, this.data});

  GetMyProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? pName;
  String? description;
  String? deposite;
  String? oldPrice;
  String? newPrice;
  String? numBids;
  String? startDate;
  String? endDate;
  String? location;
  String? userId;
  String? catId;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;

  Data(
      {this.id,
      this.pName,
      this.description,
      this.deposite,
      this.oldPrice,
      this.newPrice,
      this.numBids,
      this.startDate,
      this.endDate,
      this.location,
      this.userId,
      this.catId,
      this.createdAt,
      this.updatedAt,
      this.productImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pName = json['p_name'];
    description = json['description'];
    deposite = json['deposite'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    numBids = json['num_bids'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    location = json['location'];
    userId = json['user_id'];
    catId = json['cat_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_name'] = this.pName;
    data['description'] = this.description;
    data['deposite'] = this.deposite;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['num_bids'] = this.numBids;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['location'] = this.location;
    data['user_id'] = this.userId;
    data['cat_id'] = this.catId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  String? pId;
  String? path;
  String? createdAt;
  String? updatedAt;

  ProductImages({this.id, this.pId, this.path, this.createdAt, this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['p_id'];
    path = json['path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_id'] = this.pId;
    data['path'] = this.path;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
