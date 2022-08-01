class FavoriteModel {
  bool? status;
  String? errNum;
  String? msg;

  FavoriteModel({this.status, this.errNum, this.msg});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }
}
