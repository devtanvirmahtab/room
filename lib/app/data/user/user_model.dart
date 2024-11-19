class UserModel {
  final String? uid;
  final String? name;
  final String? photo;
  final String? email;

  UserModel({this.uid, this.name, this.photo,this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['username'],
      photo: json['profilePhoto'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() => {
    "username": name,
    "email": email,
    "profilePhoto": photo,
    "uid": uid,
  };
}
