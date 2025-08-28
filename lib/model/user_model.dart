class UserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? coverImage;
  bool? isEmailVerified;

  UserModel(
      {this.name,
      this.phone,
      this.email,
      this.uId,
      this.image,
      this.bio,
      this.coverImage,
      this.isEmailVerified});

  //UserModel.fromJson(this.name, this.phone, this.email, this.uId);
  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    phone = json?['phone'];
    email = json?['email'];
    uId = json?['uId'];
    image = json?['image'];
    bio = json?['bio'];
    coverImage = json?['coverImage'] ?? '';
    isEmailVerified = json?['isEmailVerifiedId'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'coverImage': coverImage,
      'isEmailVerifiedId': isEmailVerified,
    };
  }
}
