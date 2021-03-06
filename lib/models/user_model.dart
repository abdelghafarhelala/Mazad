class UserModel {
  bool? status;
  String? message;
  UserData? data;
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? age;
  String? bankAccount;
  String? vodafoneAccount;
  String? token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    bankAccount = json['bank_account'];
    vodafoneAccount = json['vodafone_account'];
    token = json['token'];
  }
}
