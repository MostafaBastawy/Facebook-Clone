class UserDataModel {
  String? name;
  String? email;
  String? phone;
  String? profileImage;
  String? coverImage;
  String? bio;

  UserDataModel(
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.coverImage,
    this.bio,
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
    };
  }
}
