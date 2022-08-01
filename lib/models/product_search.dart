class ProductSearchModel {
  bool? status;
  String? message;
  List<SearchProduct>? data;

  ProductSearchModel({this.status, this.message, this.data});

  ProductSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchProduct>[];
      json['data'].forEach((v) {
        data!.add(new SearchProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchProduct {
  int? id;
  String? pName;
  String? description;
  String? numBids;
  String? deposite;
  String? oldPrice;
  String? newPrice;
  String? startDate;
  String? endDate;
  String? location;
  String? userId;
  String? catId;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;

  SearchProduct(
      {this.id,
      this.pName,
      this.description,
      this.numBids,
      this.deposite,
      this.oldPrice,
      this.newPrice,
      this.startDate,
      this.endDate,
      this.location,
      this.userId,
      this.catId,
      this.createdAt,
      this.updatedAt,
      this.productImages});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pName = json['p_name'];
    description = json['description'];
    numBids = json['num_bids'];
    deposite = json['deposite'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
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
    data['num_bids'] = this.numBids;
    data['deposite'] = this.deposite;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
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
