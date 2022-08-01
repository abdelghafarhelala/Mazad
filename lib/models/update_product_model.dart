class UpdateProductModel {
  String? status;
  String? message;
  Data? data;

  UpdateProductModel({this.status, this.message, this.data});

  UpdateProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
      this.updatedAt});

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
    return data;
  }
}
