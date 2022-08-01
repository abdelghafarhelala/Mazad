class MazadModel {
  bool? status;
  int? errNum;
  // String? errNum;
  String? msg;

  MazadModel({this.status, this.errNum, this.msg});

  MazadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }
}
