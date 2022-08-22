class ResultWalletModel {
  ResultWalletModel({
    this.data,
    this.message,
    this.status,
  });

  List<WalletModel>? data;
  String? message;
  bool? status;

  factory ResultWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultWalletModel(
        data: List<WalletModel>.from(
            json["data"].map((x) => WalletModel.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class WalletModel {
  WalletModel({
    this.walletId,
    this.walletName,
    this.walletMoney,
    this.walletColor,
    this.walletCreatedAt,
    this.walletUpdatedAt,
    this.walletIsActive,
  });

  int? walletId;
  String? walletName;
  int? walletMoney;
  String? walletColor;
  DateTime? walletCreatedAt;
  DateTime? walletUpdatedAt;
  bool? walletIsActive;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        walletId: json["wallet_id"],
        walletName: json["wallet_name"],
        walletMoney: json["wallet_money"],
        walletColor: json["wallet_color"],
        walletCreatedAt: DateTime.parse(json["wallet_created_at"]),
        walletUpdatedAt: DateTime.parse(json["wallet_updated_at"]),
        walletIsActive: json["wallet_is_active"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_id": walletId,
        "wallet_name": walletName,
        "wallet_money": walletMoney,
        "wallet_color": walletColor,
        "wallet_created_at": walletCreatedAt!.toIso8601String(),
        "wallet_updated_at": walletUpdatedAt!.toIso8601String(),
        "wallet_is_active": walletIsActive,
      };
}

class ResultMemberWalletModel {
  ResultMemberWalletModel({
    this.data,
    this.message,
    this.status,
  });

  List<MemberWalletModel>? data;
  String? message;
  bool? status;

  factory ResultMemberWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultMemberWalletModel(
        data: List<MemberWalletModel>.from(
            json["data"].map((x) => MemberWalletModel.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class MemberWalletModel {
  MemberWalletModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userStatus,
  });

  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  String? userStatus;

  factory MemberWalletModel.fromJson(Map<String, dynamic> json) =>
      MemberWalletModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userPhoto: json["user_photo"],
        userGender: json["user_gender"],
        userTglLahir: DateTime.parse(json["user_tgl_lahir"]),
        userAddress: json["user_address"],
        userStatus: json["user_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_photo": userPhoto,
        "user_gender": userGender,
        "user_tgl_lahir":
            "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
        "user_address": userAddress,
        "user_status": userStatus,
      };
}

class ResultUserToWalletModel {
  ResultUserToWalletModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<UserToWalletModel>? data;

  factory ResultUserToWalletModel.fromJson(Map<String, dynamic> json) =>
      ResultUserToWalletModel(
        status: json["status"],
        message: json["message"],
        data: List<UserToWalletModel>.from(
            json["data"].map((x) => UserToWalletModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserToWalletModel {
  UserToWalletModel({
    this.userId,
    this.userName,
    this.userPassword,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  String? userId;
  String? userName;
  String? userPassword;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  DateTime? userCreatedAt;
  DateTime? userUpdatedAt;

  factory UserToWalletModel.fromJson(Map<String, dynamic> json) =>
      UserToWalletModel(
        userId: json["userId"],
        userName: json["userName"],
        userPassword: json["userPassword"],
        userEmail: json["userEmail"],
        userPhone: json["userPhone"],
        userPhoto: json["userPhoto"],
        userGender: json["userGender"],
        userTglLahir: DateTime.parse(json["userTglLahir"]),
        userAddress: json["userAddress"],
        userCreatedAt: DateTime.parse(json["userCreatedAt"]),
        userUpdatedAt: DateTime.parse(json["userUpdatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userPassword": userPassword,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "userPhoto": userPhoto,
        "userGender": userGender,
        "userTglLahir":
            "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
        "userAddress": userAddress,
        "userCreatedAt": userCreatedAt!.toIso8601String(),
        "userUpdatedAt": userUpdatedAt!.toIso8601String(),
      };
}
