class ProfileModel {
  bool? status;
  ProfileData? profileData;
  String? data;

  ProfileModel({this.status, this.profileData, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profileData =
        json['message'] != null ? ProfileData.fromJson(json['message']) : null;
    data = json['data'];
  }
}

class ProfileData {
  String? name;
  String? email;
  int? phone;
  String? password;
  int? age;
  String? bankAccount;
  String? vodafoneAccount;

  ProfileData(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.age,
      this.bankAccount,
      this.vodafoneAccount});

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    age = json['age'];
    bankAccount = json['bank_account'];
    vodafoneAccount = json['vodafone_account'];
  }
}
