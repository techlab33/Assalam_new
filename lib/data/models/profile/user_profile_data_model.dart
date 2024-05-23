// import 'dart:convert';
//
// UserProfileDataModel userProfileDataModelFromJson(String str) =>
//     UserProfileDataModel.fromJson(json.decode(str));
//
// String userProfileDataModelToJson(UserProfileDataModel data) =>
//     json.encode(data.toJson());
//
// class UserProfileDataModel {
//   User? user;
//
//   UserProfileDataModel({
//     this.user,
//   });
//
//   factory UserProfileDataModel.fromJson(Map<String, dynamic> json) =>
//       UserProfileDataModel(
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "user": user?.toJson(),
//   };
// }
//
// class User {
//   int id;
//   String name;
//   String email;
//   String role;
//   DateTime emailVerifiedAt;
//   String ? address;
//   String mobile;
//   String? bankAccountNumber;
//   String? bankName;
//   String status;
//   SubscriptionType? subscriptionType;
//   DateTime subscriptionStartDate;
//   DateTime subscriptionEndDate;
//   String subscriptionStatus;
//   String? paymentMethod;
//   String image;
//   dynamic deletedAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.role,
//     required this.emailVerifiedAt,
//     this.address,
//     required this.mobile,
//     this.bankAccountNumber,
//     this.bankName,
//     required this.status,
//     this.subscriptionType,
//     required this.subscriptionStartDate,
//     required this.subscriptionEndDate,
//     required this.subscriptionStatus,
//     this.paymentMethod,
//     required this.image,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     role: json["role"],
//     emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//     address: json["address"],
//     mobile: json["mobile"],
//     bankAccountNumber: json["bank_account_number"],
//     bankName: json["bank_name"],
//     status: json["status"],
//     subscriptionType: json["subscription_type"] == null
//         ? null
//         : SubscriptionType.fromJson(json["subscription_type"]),
//     subscriptionStartDate: DateTime.parse(json["subscription_start_date"]),
//     subscriptionEndDate: DateTime.parse(json["subscription_end_date"]),
//     subscriptionStatus: json["subscription_status"],
//     paymentMethod: json["payment_method"],
//     image: json["image"],
//     deletedAt: json["deleted_at"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "role": role,
//     "email_verified_at": emailVerifiedAt.toIso8601String(),
//     "address": address,
//     "mobile": mobile,
//     "bank_account_number": bankAccountNumber,
//     "bank_name": bankName,
//     "status": status,
//     "subscription_type": subscriptionType?.toJson(),
//     "subscription_start_date": subscriptionStartDate.toIso8601String(),
//     "subscription_end_date": subscriptionEndDate.toIso8601String(),
//     "subscription_status": subscriptionStatus,
//     "payment_method": paymentMethod,
//     "image": image,
//     "deleted_at": deletedAt,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class SubscriptionType {
//   int id;
//   String name;
//   String price;
//   String membershipLevelManageId;
//   String description;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Level level;
//   List<Level> features;
//
//   SubscriptionType({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.membershipLevelManageId,
//     required this.description,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.level,
//     required this.features,
//   });
//
//   factory SubscriptionType.fromJson(Map<String, dynamic> json) =>
//       SubscriptionType(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         membershipLevelManageId: json["membership_level_manage_id"],
//         description: json["description"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         level: Level.fromJson(json["level"]),
//         features: List<Level>.from(
//             json["features"].map((x) => Level.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "price": price,
//     "membership_level_manage_id": membershipLevelManageId,
//     "description": description,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "level": level.toJson(),
//     "features": List<dynamic>.from(features.map((x) => x.toJson())),
//   };
// }
//
// class Level {
//   int id;
//   String name;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Pivot? pivot;
//   String? limit;
//
//   Level({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     this.pivot,
//     this.limit,
//   });
//
//   factory Level.fromJson(Map<String, dynamic> json) => Level(
//     id: json["id"],
//     name: json["name"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
//     limit: json["limit"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "pivot": pivot?.toJson(),
//     "limit": limit,
//   };
// }
//
// class Pivot {
//   String membershipPackageManageId;
//   String featureManageId;
//   String id;
//
//   Pivot({
//     required this.membershipPackageManageId,
//     required this.featureManageId,
//     required this.id,
//   });
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//     membershipPackageManageId: json["membership_package_manage_id"],
//     featureManageId: json["feature_manage_id"],
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "membership_package_manage_id": membershipPackageManageId,
//     "feature_manage_id": featureManageId,
//     "id": id,
//   };
// }


import 'dart:convert';

UserProfileDataModel userProfileDataModelFromJson(String str) =>
    UserProfileDataModel.fromJson(json.decode(str));

String userProfileDataModelToJson(UserProfileDataModel data) =>
    json.encode(data.toJson());

class UserProfileDataModel {
  User? user;

  UserProfileDataModel({
    this.user,
  });

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) =>
      UserProfileDataModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? role;
  DateTime? emailVerifiedAt;
  String? address;
  String? mobile;
  String? bankAccountNumber;
  String? bankName;
  String? status;
  SubscriptionType? subscriptionType;
  DateTime? subscriptionStartDate;
  DateTime? subscriptionEndDate;
  String? subscriptionStatus;
  String? paymentMethod;
  String? image;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.address,
    this.mobile,
    this.bankAccountNumber,
    this.bankName,
    this.status,
    this.subscriptionType,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.subscriptionStatus,
    this.paymentMethod,
    this.image,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    address: json["address"],
    mobile: json["mobile"],
    bankAccountNumber: json["bank_account_number"],
    bankName: json["bank_name"],
    status: json["status"],
    subscriptionType: json["subscription_type"] == null
        ? null
        : SubscriptionType.fromJson(json["subscription_type"]),
    subscriptionStartDate: json["subscription_start_date"] == null
        ? null
        : DateTime.parse(json["subscription_start_date"]),
    subscriptionEndDate: json["subscription_end_date"] == null
        ? null
        : DateTime.parse(json["subscription_end_date"]),
    subscriptionStatus: json["subscription_status"],
    paymentMethod: json["payment_method"],
    image: json["image"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "address": address,
    "mobile": mobile,
    "bank_account_number": bankAccountNumber,
    "bank_name": bankName,
    "status": status,
    "subscription_type": subscriptionType?.toJson(),
    "subscription_start_date": subscriptionStartDate?.toIso8601String(),
    "subscription_end_date": subscriptionEndDate?.toIso8601String(),
    "subscription_status": subscriptionStatus,
    "payment_method": paymentMethod,
    "image": image,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class SubscriptionType {
  int? id;
  String? name;
  String? price;
  String? membershipLevelManageId;
  String? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Level? level;
  List<Level>? features;

  SubscriptionType({
    this.id,
    this.name,
    this.price,
    this.membershipLevelManageId,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.features,
  });

  factory SubscriptionType.fromJson(Map<String, dynamic> json) =>
      SubscriptionType(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        membershipLevelManageId: json["membership_level_manage_id"],
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        features: json["features"] == null
            ? null
            : List<Level>.from(json["features"].map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "membership_level_manage_id": membershipLevelManageId,
    "description": description,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "level": level?.toJson(),
    "features": features == null
        ? null
        : List<dynamic>.from(features!.map((x) => x.toJson())),
  };
}

class Level {
  int? id;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;
  String? limit;

  Level({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.limit,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
    "limit": limit,
  };
}

class Pivot {
  String? membershipPackageManageId;
  String? featureManageId;
  String? id;

  Pivot({
    this.membershipPackageManageId,
    this.featureManageId,
    this.id,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    membershipPackageManageId: json["membership_package_manage_id"],
    featureManageId: json["feature_manage_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "membership_package_manage_id": membershipPackageManageId,
    "feature_manage_id": featureManageId,
    "id": id,
  };
}
