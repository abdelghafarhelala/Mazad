class DeleteProductModel {
  bool? status;
  Deleted? message;
  String? data;

  DeleteProductModel({this.status, this.message, this.data});

  DeleteProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Deleted.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Deleted {
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
  String? createdAt;
  String? updatedAt;

  Deleted(
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
      this.createdAt,
      this.updatedAt});

  Deleted.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
