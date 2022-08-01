class AddPostModel {
  bool? status;
  String? errNum;
  String? msg;
  int? data;

  AddPostModel({this.status, this.errNum, this.msg, this.data});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'];
  }
}
