class GetAllProducts {
  bool? status;
  List<Message>? message;
  String? data;

  GetAllProducts({this.status, this.message, this.data});

  GetAllProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
    data = json['data'];
  }
}

class Message {
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
  String? createdAt;
  String? updatedAt;

  Message(
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

  Message.fromJson(Map<String, dynamic> json) {
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
}
