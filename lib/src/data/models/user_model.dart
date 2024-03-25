import '../../utils/constants/api_data.dart';

class UserModel {
  String? token;
  String? companyLogo;
  int? userId;
  String? userAccount;
  String? userName;
  String? password;
  String? userType;
  String? userImageThumbnail;
  String? branchOfficeCode;
  String? branchOfficeName;
  String? resetPassword;
  String? language;
  bool? administrator;
  int? timeout;
  bool? rememberMe;

  UserModel(
      {this.token,
      this.companyLogo,
      this.userId,
      this.userAccount,
      this.userName,
      this.password,
      this.userType,
      this.userImageThumbnail,
      this.branchOfficeCode,
      this.branchOfficeName,
      this.resetPassword,
      this.language,
      this.administrator,
      this.rememberMe,
      this.timeout});

  static UserModel empty() => UserModel(userName: '');

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    companyLogo = json['company_logo'];
    userId = json['user_id'];
    userAccount = json['user_account'];
    userName = json['user_name'];
    userType = json['user_type'];
    userImageThumbnail = '$dataDomain/${json['user_image_thumbnail']}';
    branchOfficeCode = json['branch_office_code'];
    branchOfficeName = json['branch_office_name'];
    resetPassword = json['reset_password'];
    language = json['language'];
    administrator = json['administrator'];
    timeout = json['timeout'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'password': password,
      'company_id': '005',
      'remember_me': true
    };
  }
}
