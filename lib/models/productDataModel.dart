class ProductDataModel {
  bool? status;
  String? errNum;
  String? msg;
  ProductDataDetails? data;

  ProductDataModel({this.status, this.errNum, this.msg, this.data});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data =
        json['data'] != null ? ProductDataDetails.fromJson(json['data']) : null;
  }
}

class ProductDataDetails {
  int? id;
  String? pName;
  String? description;
  int? numBids;
  int? deposite;
  int? oldPrice;
  int? newPrice;
  String? startDate;
  String? endDate;
  String? location;
  int? userId;
  int? catId;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;
  List<String>? comment;

  ProductDataDetails(
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
      this.productImages,
      this.comment});

  ProductDataDetails.fromJson(Map<String, dynamic> json) {
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
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['comment'] != null) {
      comment = <String>[];
      comment!.forEach((v) {
        comment!.add(v);
      });
    }
  }
}

class ProductImages {
  int? id;
  int? pId;
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
}
