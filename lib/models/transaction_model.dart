class ResultTransactionModel {
  ResultTransactionModel({
    this.data,
    this.message,
    this.status,
  });

  List<TransactionModel>? data;
  String? message;
  bool? status;

  factory ResultTransactionModel.fromJson(Map<String, dynamic> json) =>
      ResultTransactionModel(
        data: List<TransactionModel>.from(
            json["data"].map((x) => TransactionModel.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TransactionModel {
  TransactionModel({
    this.transId,
    this.transType,
    this.transCategory,
    this.transDetail,
    this.transPrice,
    this.transDate,
    this.transIsSeen,
    this.transUser,
  });

  int? transId;
  String? transType;
  String? transCategory;
  String? transDetail;
  int? transPrice;
  DateTime? transDate;
  bool? transIsSeen;
  TransUser? transUser;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        transId: json["trans_id"],
        transType: json["trans_type"],
        transCategory: json["trans_category"],
        transDetail: json["trans_detail"],
        transPrice: json["trans_price"],
        transDate: DateTime.parse(json["trans_date"]),
        transIsSeen: json["trans_is_seen"],
        transUser: TransUser.fromJson(json["trans_user"]),
      );

  Map<String, dynamic> toJson() => {
        "trans_id": transId,
        "trans_type": transType,
        "trans_category": transCategory,
        "trans_detail": transDetail,
        "trans_price": transPrice,
        "trans_date": transDate!.toIso8601String(),
        "trans_is_seen": transIsSeen,
        "trans_user": transUser!.toJson(),
      };
}

class TransUser {
  TransUser({
    this.transUserId,
    this.transUserName,
    this.transUserEmail,
    this.transUserPhone,
    this.transUserPhoto,
  });

  int? transUserId;
  String? transUserName;
  String? transUserEmail;
  String? transUserPhone;
  String? transUserPhoto;

  factory TransUser.fromJson(Map<String, dynamic> json) => TransUser(
        transUserId: json["trans_user_id"],
        transUserName: json["trans_user_name"],
        transUserEmail: json["trans_user_email"],
        transUserPhone: json["trans_user_phone"],
        transUserPhoto: json["trans_user_photo"],
      );

  Map<String, dynamic> toJson() => {
        "trans_user_id": transUserId,
        "trans_user_name": transUserName,
        "trans_user_email": transUserEmail,
        "trans_user_phone": transUserPhone,
        "trans_user_photo": transUserPhoto,
      };
}
