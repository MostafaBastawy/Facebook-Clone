class UserDataModel {
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  String? coverImage;
  String? bio;
  String? uid;

  UserDataModel(
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.bio,
    this.uid,
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
      'uid': uid,
    };
  }
}
