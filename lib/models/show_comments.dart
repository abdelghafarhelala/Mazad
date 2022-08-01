class ShowComments {
  bool? status;
  String? msg;
  List<CommentShow>? data;

  ShowComments({this.status, this.msg, this.data});

  ShowComments.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    msg = json['msg'];
    if (json['data'] != null) {
      data = <CommentShow>[];
      json['data'].forEach((v) {
        data!.add(new CommentShow.fromJson(v));
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

class CommentShow {
  int? id;
  String? userId;
  String? productId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  Usercomment? usercomment;

  CommentShow(
      {this.id,
      this.userId,
      this.productId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.usercomment});

  CommentShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    usercomment = json['usercomment'] != null
        ? new Usercomment.fromJson(json['usercomment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.usercomment != null) {
      data['usercomment'] = this.usercomment!.toJson();
    }
    return data;
  }
}

class Usercomment {
  int? id;
  String? name;
  String? profilePicture;

  Usercomment({this.id, this.name, this.profilePicture});

  Usercomment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
