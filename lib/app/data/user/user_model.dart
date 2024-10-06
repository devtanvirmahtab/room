class UserModel {
  final String? uid;
  final String? name;
  final String? photo;

  UserModel({this.uid, this.name, this.photo});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['username'],
      photo: json['profilePhoto'],
    );
  }
}
