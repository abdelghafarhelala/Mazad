class updateProfileModel {
  String? status;
  String? message;
  Data? data;

  updateProfileModel({this.status, this.message, this.data});

  updateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? twoFactorConfirmedAt;
  String? phone;
  String? age;
  String? bankAccount;
  String? vodafoneAccount;
  String? createdAt;
  String? updatedAt;
  String? passwordHelperKey;
  String? profilePicture;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.twoFactorSecret,
      this.twoFactorRecoveryCodes,
      this.twoFactorConfirmedAt,
      this.phone,
      this.age,
      this.bankAccount,
      this.vodafoneAccount,
      this.createdAt,
      this.updatedAt,
      this.passwordHelperKey,
      this.profilePicture});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    phone = json['phone'];
    age = json['age'];
    bankAccount = json['bank_account'];
    vodafoneAccount = json['vodafone_account'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    passwordHelperKey = json['password_helper_key'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['phone'] = this.phone;
    data['age'] = this.age;
    data['bank_account'] = this.bankAccount;
    data['vodafone_account'] = this.vodafoneAccount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['password_helper_key'] = this.passwordHelperKey;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
