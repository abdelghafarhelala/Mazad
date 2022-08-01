class ProfileModel {
  bool? status;
  profileData? message;
  String? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] != null
        ? new profileData.fromJson(json['message'])
        : null;
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

class profileData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? age;
  String? bankAccount;
  String? vodafoneAccount;
  String? profilePicture;

  profileData(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.age,
      this.bankAccount,
      this.vodafoneAccount,
      this.profilePicture});

  profileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    age = json['age'];
    bankAccount = json['bank_account'];
    vodafoneAccount = json['vodafone_account'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['age'] = this.age;
    data['bank_account'] = this.bankAccount;
    data['vodafone_account'] = this.vodafoneAccount;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
